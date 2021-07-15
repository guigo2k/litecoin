terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "name" {
  default = "litecoin-k3s"
}

module "vpc" {
  source               = "terraform-aws-modules/vpc/aws"
  name                 = var.name
  cidr                 = "10.0.0.0/16"
  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  enable_nat_gateway   = true
  enable_dns_hostnames = true
}

module "k3s" {
  source        = "./k3s-cluster"
  name          = var.name
  vpc_id        = module.vpc.vpc_id
  ssm_manifests = values(aws_ssm_parameter.manifests)[*].name
  depends_on    = [module.vpc]

  # servers
  server_elb_subnets   = module.vpc.public_subnets
  server_ec2_subnets   = module.vpc.private_subnets
  server_instance_type = "t3.small"
  server_node_size     = 3
  server_volume_size   = 20

  # agents
  agent_elb_subnets   = module.vpc.public_subnets
  agent_ec2_subnets   = module.vpc.private_subnets
  agent_instance_type = "t3.small"
  agent_min_size      = 3
  agent_max_size      = 10
  agent_volume_size   = 20

  # agent_listener = [{
  #   instance_port      = 80
  #   instance_protocol  = "http"
  #   lb_port            = 443
  #   lb_protocol        = "https"
  #   ssl_certificate_id = module.ssl.certificate_arn
  # }]
}

resource "aws_ssm_parameter" "manifests" {
  for_each  = fileset(path.root, "manifests/**")
  name      = format("%s-%s", var.name, basename(each.value))
  type      = "SecureString"
  value     = file(each.value)
  overwrite = true
}
