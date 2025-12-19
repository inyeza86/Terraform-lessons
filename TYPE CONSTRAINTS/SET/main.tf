# The instance_type variable is defined as a set of strings in the variables.tf file.
# so we need to convert it to a list before accessing its first element in the main.tf file.
# but it is best practice to use set when orders does not matter.
resource "aws_instance" "example" {
  ami           = "ami-0ecb62995f68bb549"
  instance_type = tolist(var.instance_type)[0]
  tags = {
    Name = "dev-instance"
  }
}
