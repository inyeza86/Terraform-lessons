# Create a security group with ingress and egress rules
resource "aws_security_group" "example" {
  description = "Example Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "web-sg"
  }

}

# Create an EC2 instance and associate it with the security group
resource "aws_instance" "example" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.example.id]

  tags = merge(var.resource_tags, {
    Name = "web-server"
    }
  )

  lifecycle {
    replace_triggered_by = [aws_security_group.example] # Replace the instance when the security group is updated
  }

  depends_on = [aws_security_group.example]

}
