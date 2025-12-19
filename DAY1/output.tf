# ouput the ARN  and the name of the S3 bucket ( you can also run "terraform output" command to get the same information)

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.arn

}

output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.my_bucket.bucket
}

output "s3_bucket_region" {
  description = "The AWS region where the S3 bucket is created"
  value       = var.aws_region
}


