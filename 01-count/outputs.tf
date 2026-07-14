output "instance_ids" {
  description = "EC2 Instance IDs"

  value = aws_instance.web[*].id
}

output "public_ips" {
  description = "EC2 Public IP Addresses"

  value = aws_instance.web[*].public_ip
}

output "private_ips" {
  description = "EC2 Private IP Addresses"

  value = aws_instance.web[*].private_ip
}