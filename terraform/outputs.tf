# ============================================
# Outputs - Terraform apply ke baad ye values
# screen pe print hongi
# ============================================

output "server_public_ip" {
  description = "WireGuard server ka Elastic IP"
  value       = aws_eip.wireguard_eip.public_ip
}

output "instance_id" {
  description = "EC2 Instance ID"
  value       = aws_instance.wireguard_server.id
}

output "instance_type" {
  description = "EC2 Instance Type"
  value       = aws_instance.wireguard_server.instance_type
}

output "security_group_id" {
  description = "Security Group ID"
  value       = aws_security_group.wireguard_sg.id
}