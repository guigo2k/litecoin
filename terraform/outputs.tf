output "k3s_security_group" {
  description = "K3s cluster security group"
  value       = module.k3s.security_group
}

output "k3s_key_pair" {
  description = "K3s cluster key pair"
  value       = module.k3s.key_pair
}

output "agent_elb_security_group" {
  description = "Agent ELB security group"
  value       = module.k3s.agent_elb_security_group
}

output "agent_ec2_security_group" {
  description = "Agent EC2 security group"
  value       = module.k3s.agent_ec2_security_group
}

output "agent_elb" {
  description = "Agent ELB"
  value       = module.k3s.agent_elb
}

output "agent_iam_role" {
  description = "Agent IAM role"
  value       = module.k3s.agent_iam_role
}

output "agent_instance_profile" {
  description = "Agent instance profile"
  value       = module.k3s.agent_instance_profile
}

output "agent_launch_template" {
  description = "Agent launch template"
  value       = module.k3s.agent_launch_template
}

output "agent_autoscaling_group" {
  description = "Agent autoscaling group"
  value       = module.k3s.agent_autoscaling_group
}

output "server_elb_security_group" {
  description = "Server ELB security group"
  value       = module.k3s.server_elb_security_group
}

output "server_ec2_security_group" {
  description = "Server EC2 security group"
  value       = module.k3s.server_ec2_security_group
}

output "server_elb" {
  description = "Server ELB"
  value       = module.k3s.server_elb
}

output "server_iam_role" {
  description = "Server IAM role"
  value       = module.k3s.server_iam_role
}

output "server_instance_profile" {
  description = "Server instance profile"
  value       = module.k3s.server_instance_profile
}

output "server_launch_template" {
  description = "Server launch template"
  value       = module.k3s.server_launch_template
}

output "server_autoscaling_group" {
  description = "Server autoscaling group"
  value       = module.k3s.server_autoscaling_group
}
