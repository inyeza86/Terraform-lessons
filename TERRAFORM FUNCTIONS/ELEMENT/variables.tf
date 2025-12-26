#=============================
# AMI ID variable
#=============================
variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
  default     = "ami-0ecb62995f68bb549"
}

#=============================
# instance type variable
#=============================
variable "instance_type" {
  type = map(string)

  description = "The type of the EC2 instance"
  default = {
    dev     = "t2.micro"
    staging = "t2.medium"
    prod    = "t3.large"
  }
}
#=============================
# Environment
#=============================
variable "environment" {
  type        = string
  description = "The deployment environment"
  default     = "dev"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of subnet IDs to launch the EC2 instance in"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}
