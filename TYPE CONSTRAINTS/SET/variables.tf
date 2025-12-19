variable "instance_type" {
  type        = set(string)
  description = "The type of instance to launch"
  default     = ["t2.micro", "t2.medium", "t2.large", "t2.micro"]
}
