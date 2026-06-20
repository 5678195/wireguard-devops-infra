# ============================================
# WireGuard DevOps Infra - Terraform Config
# ============================================

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# ----------------------------------------
# AWS Provider - Region set kar rahe hain
# ----------------------------------------
provider "aws" {
  region = var.aws_region
}

# ----------------------------------------
# Security Group - Firewall rules
# ----------------------------------------
resource "aws_security_group" "wireguard_sg" {
  name        = "wireguard-sg"
  description = "WireGuard VPN Security Group"

  # WireGuard VPN port - UDP
  ingress {
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana dashboard
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus
  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # All outbound traffic allow
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "wireguard-sg"
    Project = "wireguard-devops-infra"
  }
}

# ----------------------------------------
# EC2 Instance - Main VPN Server
# ----------------------------------------
resource "aws_instance" "wireguard_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.wireguard_sg.id]

  root_block_device {
    volume_size = 20
    volume_type = "gp3"
  }

  tags = {
    Name    = "wireguard-server"
    Project = "wireguard-devops-infra"
  }
}

# ----------------------------------------
# Elastic IP - Static IP taake restart
# pe IP change na ho
# ----------------------------------------
resource "aws_eip" "wireguard_eip" {
  instance = aws_instance.wireguard_server.id
  domain   = "vpc"

  tags = {
    Name    = "wireguard-eip"
    Project = "wireguard-devops-infra"
  }
}