output "server_ids" {
  value = values(aws_instance.example)[*].id
}
