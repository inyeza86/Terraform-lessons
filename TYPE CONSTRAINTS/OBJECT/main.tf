resource "aws_instance" "example" {
  count         = var.config.instance_count
  ami           = "ami-0ecb62995f68bb549"
  instance_type = var.config.instance_type
  monitoring    = var.config.monitoring_enabled
  tags          = var.config.tags
}
