output "subnet_id" {
  description = "The subnet ID where the EC2 instance is launched"
  value       = aws_instance.web_server.subnet_id
}

output "availability_zone" {
  description = "The availability zone where the EC2 instance is launched"
  value       = aws_instance.web_server.availability_zone
}
