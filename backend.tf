terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket-fiap"
    key            = "terraform/state"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks-fiap"
  }
}
