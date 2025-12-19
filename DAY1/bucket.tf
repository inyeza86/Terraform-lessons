resource "aws_s3_bucket" "my_bucket" {
  bucket = "${var.project-name}-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name        = local.common_tags.Name
    Environment = local.common_tags.Environment
    Project     = local.common_tags.Project
  }
}

locals {
  common_tags = {
    Name        = "My bucket"
    Project     = var.project-name
    Environment = var.environment
  }
}



resource "aws_s3_bucket_versioning" "my_bucket_versioning" {
  bucket = aws_s3_bucket.my_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_public_access_block" {
  bucket                  = aws_s3_bucket.my_bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "example" {
  bucket = aws_s3_bucket.my_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
  lower   = true
  numeric = true
}
