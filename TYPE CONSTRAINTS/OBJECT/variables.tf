variable "config" {
  type = object({
    region             = string,
    instance_type      = string,
    instance_count     = number,
    monitoring_enabled = bool,
    tags               = map(string),

  })

  default = {
    region             = "us-east-1"
    monitoring_enabled = false
    instance_count     = 1
    instance_type      = "t2.micro"
    tags = {
      Name        = "prod-instance"
      Environment = "production"
    }
  }
}
