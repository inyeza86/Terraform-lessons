resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.instance_type["us-east-1"]
  tags = {
    Name = "dev-instance"
  }
}
