terraform {
  backend "s3" {
    bucket       = "terraform-remote-backend-inyeza"
    key          = "prod/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "ariella-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
