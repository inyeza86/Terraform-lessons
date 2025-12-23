variable "ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
  default     = "ami-068c0051b15cdb816" #"ami-0ecb62995f68bb549"
}

# instance type variable
variable "instance_type" {
  type = string

  description = "The type of the EC2 instance"
  default     = "t2.micro"
}

# ==============================
# Tags
# ==============================

variable "resource_tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "dev"
    Team        = "DevOps"
    CostCenter  = "Engineering"
  }
}
