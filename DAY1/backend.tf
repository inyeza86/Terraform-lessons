terraform {
  backend "s3" {
    bucket       = "terraform-remote-backend-inyeza"
    key          = "prod/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}
