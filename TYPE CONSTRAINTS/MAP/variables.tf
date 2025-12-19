variable "instance_type" {
  type        = map(string)
  description = "The type of instance to launch"
  default = {
    "us-east-1" = "t2.micro"
    "us-west-1" = "t2.medium"
    "us-west-2" = "t2.large"
    "eu-west-1" = "t2.micro"
  }
}
