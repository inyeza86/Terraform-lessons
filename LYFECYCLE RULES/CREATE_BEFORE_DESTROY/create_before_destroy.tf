resource "aws_instance" "web_server" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = merge(var.resource_tags, {
    Name = "WebServer"
    Demo = "create_before_destroy_example"
    }
  )

  lifecycle {
    create_before_destroy = true
  }


}

