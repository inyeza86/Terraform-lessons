resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.environment == "development" ? "t2.micro" : "t3.micro"

  tags = {
    Name = "WebServer"
  }
}


