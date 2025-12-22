
# Create an EC2 instance and associate it with the security group
resource "aws_instance" "example" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "${var.name_prefix}${count.index + 1}"
  }
}
