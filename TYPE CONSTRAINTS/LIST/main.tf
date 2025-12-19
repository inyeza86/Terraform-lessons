resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.instance_type[0]
  tags = {
    Name = "dev-instance"
  }
}
