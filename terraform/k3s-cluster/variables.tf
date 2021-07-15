variable "name" {
  description = "Name of the K3S cluster"
  type        = string
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}

variable "token_length" {
  description = "The length of the k3s token"
  type        = number
  default     = 32
}

variable "ssh_cidr_blocks" {
  description = "A list of CIDR blocks to allow"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ssh_segurity_groups" {
  description = "A list of security group IDs to allow"
  type        = list(string)
  default     = []
}

variable "ssm_manifests" {
  description = "List of SSM parameter store manifests to deploy"
  type        = list(string)
  default     = []
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  type        = bool
  default     = false
}

variable "delete_on_termination" {
  description = "Whether volumes should be destroyed on instance termination"
  type        = bool
  default     = true
}

variable "monitoring_enabled" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = false
}

variable "agent_cidr_blocks" {
  description = "A list of CIDR blocks to attach to the ELB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "agent_ec2_subnets" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "agent_elb_subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = list(string)
}

variable "agent_access_logs" {
  description = "An access logs block"
  type        = map(string)
  default     = null
}

variable "agent_listener" {
  description = "A list of listener blocks to attach to the ELB"
  type        = list(any)
  default = [{
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }]
}

variable "agent_health_check" {
  description = "A health_check block"
  type        = map(string)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    target              = "TCP:80"
    interval            = 5
  }
}

variable "agent_managed_policy_arns" {
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role"
  type        = set(string)
  default     = []
}

variable "agent_policies" {
  description = "A list of IAM policy documents to attach to the IAM role"
  type        = set(string)
  default     = []
}

variable "agent_instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t3.small"
}

variable "agent_segurity_groups" {
  description = "A list of security group IDs"
  type        = list(string)
  default     = []
}

variable "agent_volume_size" {
  description = "The size of the volume in gigabytes"
  type        = number
  default     = 20
}

variable "agent_volume_type" {
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)"
  type        = string
  default     = "gp2"
}

variable "agent_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "agent_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 15
}

variable "agent_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 180
}

variable "agent_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  type        = string
  default     = "EC2"
}

variable "agent_termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated"
  type        = list(string)
  default     = ["OldestInstance"]
}

variable "agent_scaling_adjustment" {
  description = "The number of instances by which to scale"
  type        = number
  default     = 2
}

variable "agent_target_value" {
  description = "The target value for the metric"
  type        = number
  default     = 50.0
}

variable "server_cidr_blocks" {
  description = "A list of CIDR blocks to attach to the ELB"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "server_ec2_subnets" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "server_elb_subnets" {
  description = "A list of subnet IDs to attach to the ELB"
  type        = list(string)
}

variable "server_access_logs" {
  description = "An access logs block"
  type        = map(string)
  default     = null
}

variable "server_health_check" {
  description = "A health_check block"
  type        = map(string)
  default = {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 3
    target              = "TCP:6443"
    interval            = 5
  }
}

variable "server_managed_policy_arns" {
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role"
  type        = set(string)
  default     = []
}

variable "server_policies" {
  description = "A list of IAM policy documents to attach to the IAM role"
  type        = set(string)
  default     = []
}

variable "server_instance_type" {
  description = "The type of the instance"
  type        = string
  default     = "t3.small"
}

variable "server_segurity_groups" {
  description = "A list of security group IDs"
  type        = list(string)
  default     = []
}

variable "server_volume_size" {
  description = "The size of the volume in gigabytes"
  type        = number
  default     = 20
}

variable "server_volume_type" {
  description = "The volume type. Can be standard, gp2, gp3, io1, io2, sc1 or st1 (Default: gp2)"
  type        = string
  default     = "gp2"
}

variable "server_node_size" {
  description = "The number of Amazon EC2 instances that should be running in the group"
  type        = number
  default     = 3
}

variable "server_capacity_rebalance" {
  description = "Indicates whether capacity rebalance is enabled"
  type        = bool
  default     = true
}

variable "server_default_cooldown" {
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  type        = number
  default     = 60
}

variable "server_health_check_grace_period" {
  description = "Time (in seconds) after instance comes into service before checking health"
  type        = number
  default     = 180
}

variable "server_health_check_type" {
  description = "EC2 or ELB. Controls how health checking is done"
  type        = string
  default     = "EC2"
}

variable "server_termination_policies" {
  description = "A list of policies to decide how the instances in the Auto Scaling Group should be terminated"
  type        = list(string)
  default     = ["OldestInstance"]
}
