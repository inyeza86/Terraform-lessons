output "instance_ids" {
  description = "The IDs of the created EC2 instances"
  value       = aws_instance.web_server[*].id
}

output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.web_sg.id
}

