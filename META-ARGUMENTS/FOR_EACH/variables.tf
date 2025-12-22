variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
  default     = "ami-0ecb62995f68bb549"
}

# instance type variable
variable "instance_type" {
  type = string

  description = "The type of the EC2 instance"
  default     = "t2.micro"
}

# name prefix variable
variable "server_names" {
  type = list(string)

  description = "The prefix to use for the names of the EC2 instances"
  default = [
    "Webserver-1",
    "Webserver-2",
    "Webserver-3",
    "Nginxserver",
  ]


}
