terraform {
  backend "s3" {
    bucket         = "balu-0864321"
    key            = "04-remote-backend/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}