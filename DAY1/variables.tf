variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "project-name" {
  description = "The name of the project"
  type        = string
  default     = "test-project"

}
