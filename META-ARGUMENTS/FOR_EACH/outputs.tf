# define the output for the server IDs
output "server_ids" {
  value = values(aws_instance.example)[*].id
}
