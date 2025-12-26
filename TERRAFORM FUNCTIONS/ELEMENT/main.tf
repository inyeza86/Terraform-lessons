resource "aws_instance" "web_server" {
  ami               = var.ami_id
  instance_type     = lookup(var.instance_type, var.environment, "t2.micro")
  availability_zone = element(var.availability_zones, 0)

  tags = {
    Name        = "${var.environment}-server"
    Environment = var.environment
  }
}
