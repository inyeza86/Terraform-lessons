
# Create a Terraform configuration to create multiple EC2 instances based on the provided list of server names.
# The configuration should use the `aws_instance` resource and the `for_each` argument to create instances for each server name in the list.
resource "aws_instance" "example" {
  for_each      = toset(var.server_names)
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${each.value}"
  }
}
