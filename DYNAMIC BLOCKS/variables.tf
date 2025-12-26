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

# ==============================
# Security Group Rules  
# ==============================
variable "ingress_rules" {
  description = "List of ingress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # HTTP access from anywhere   
    },
    {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] # HTTPS access from anywhere
    }
  ]
}
variable "egress_rules" {
  description = "List of egress rules for the security group"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"          # All protocols
      cidr_blocks = ["0.0.0.0/0"] # Allow all outbound traffic
    }
  ]
}
