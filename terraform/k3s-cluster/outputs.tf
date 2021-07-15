output "security_group" {
  description = "Cluster default security group"
  value       = aws_security_group.k3s
}

output "key_pair" {
  description = "Cluster key pair"
  value       = aws_key_pair.k3s
}

output "agent_elb_security_group" {
  description = "Agent ELB security group"
  value       = aws_security_group.agent_elb
}

output "agent_ec2_security_group" {
  description = "Agent EC2 security group"
  value       = aws_security_group.agent_ec2
}

output "agent_elb" {
  description = "Agent ELB"
  value       = aws_elb.agent
}

output "agent_iam_role" {
  description = "Agent IAM role"
  value       = aws_iam_role.agent
}

output "agent_instance_profile" {
  description = "Agent instance profile"
  value       = aws_iam_instance_profile.agent
}

output "agent_launch_template" {
  description = "Agent launch template"
  value       = aws_launch_template.agent.arn
}

output "agent_autoscaling_group" {
  description = "Agent autoscaling group"
  value       = aws_autoscaling_group.agent
}

output "server_elb_security_group" {
  description = "Server ELB security group"
  value       = aws_security_group.server_elb
}

output "server_ec2_security_group" {
  description = "Server EC2 security group"
  value       = aws_security_group.server_ec2
}

output "server_elb" {
  description = "Server ELB"
  value       = aws_elb.server
}

output "server_iam_role" {
  description = "Server IAM role"
  value       = aws_iam_role.server
}

output "server_instance_profile" {
  description = "Server instance profile"
  value       = aws_iam_instance_profile.server
}

output "server_launch_template" {
  description = "Server launch template"
  value       = aws_launch_template.server.arn
}

output "server_autoscaling_group" {
  description = "Server autoscaling group"
  value       = aws_autoscaling_group.server
}
