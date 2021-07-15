terraform {
  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "<=2.0.0"
    }
  }
}

locals {
  server = format("%s-server", var.name)
  agent  = format("%s-agent", var.name)
}

resource "random_password" "k3s" {
  length  = var.token_length
  special = false
}

resource "tls_private_key" "k3s" {
  algorithm = "RSA"
  rsa_bits  = "2048"
}

resource "aws_key_pair" "k3s" {
  key_name   = format("%s-key", var.name)
  public_key = tls_private_key.k3s.public_key_openssh
}

resource "aws_ssm_parameter" "public_key" {
  name      = format("%s-public-key", var.name)
  type      = "SecureString"
  value     = tls_private_key.k3s.public_key_openssh
  overwrite = true
}

resource "aws_ssm_parameter" "private_key" {
  name      = format("%s-private-key", var.name)
  type      = "SecureString"
  value     = tls_private_key.k3s.private_key_pem
  overwrite = true
}

resource "aws_security_group" "k3s" {
  description = format("%s security group", var.name)
  name        = format("%s", var.name)
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    self      = true
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = var.ssh_cidr_blocks
    security_groups = var.ssh_segurity_groups
  }
}
