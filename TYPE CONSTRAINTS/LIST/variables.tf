variable "instance_type" {
  type        = list(string)
  description = "The type of instance to launch"
  default     = ["t2.micro", "t3.micro", "t2.medium", "t3.medium"]
}
