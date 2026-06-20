# ============================================
# Variables - Sari configurable values yahan
# ============================================

variable "aws_region" {
  description = "AWS region jahan server deploy hoga"
  type        = string
  default     = "eu-central-1"
}

variable "ami_id" {
  description = "Ubuntu 22.04 AMI ID"
  type        = string
  default     = "ami-0faab6bdbac9486fb"  # Ubuntu 22.04 eu-central-1
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS Key Pair name - SSH access ke liye"
  type        = string
  default     = "wireguard-key"
}