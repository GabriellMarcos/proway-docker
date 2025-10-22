cat > outputs.tf << 'EOF'
output "instance_id" {
  description = "ID da instância EC2"
  value       = aws_instance.pizzaria_ec2.id
}

output "instance_public_ip" {
  description = "IP público da instância"
  value       = aws_instance.pizzaria_ec2.public_ip
}

output "security_group_id" {
  description = "ID do Security Group"
  value       = aws_security_group.pizzaria_sg.id
}

output "application_url_frontend" {
  description = "URL do Frontend"
  value       = "http://${aws_instance.pizzaria_ec2.public_ip}:3000"
}

output "application_url_backend" {
  description = "URL do Backend"
  value       = "http://${aws_instance.pizzaria_ec2.public_ip}:5000"
}
EOF
