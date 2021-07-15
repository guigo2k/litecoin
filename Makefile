SHELL := /bin/bash
NAME  := litecoin-k3s

.SILENT: # Run all targets in silent mode
.PHONY:  help cluster deploy kubeconfig ssh-key clean

help: ## Prints this help
	awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
			{printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' \
			$(MAKEFILE_LIST)

cluster: ## Creates the K3s cluster
	terraform -chdir=terraform init
	terraform -chdir=terraform apply \
		-var="name=$(NAME)" \
		-auto-approve

deploy: ## Deploys the Helm chart
	helm upgrade litecoin ./chart -f ./chart/values.yaml \
		--kubeconfig ./kubeconfig.yaml \
		--install --atomic --debug

kubeconfig: ## Gets the Kubeconfig file
	aws ssm get-parameter \
		--name "$(NAME)-kubeconfig" \
		--region us-east-1 \
		--with-decryption \
		--output text \
		--query Parameter.Value \
		> kubeconfig.yaml && \
		chmod 600 kubeconfig.yaml

ssh-key: ## Gets the instances ssh key
	aws ssm get-parameter \
		--name "$(NAME)-private-key" \
		--region us-east-1 \
		--with-decryption \
		--output text \
		--query Parameter.Value \
		> $(NAME).pem && \
		chmod 600 $(NAME).pem

clean: ## Deletes all resources
	terraform -chdir=terraform init
	terraform -chdir=terraform destroy \
		-var="name=$(NAME)" \
		-auto-approve
	aws ssm delete-parameter \
		--name "$(NAME)-kubeconfig" \
		--region us-east-1 || true
