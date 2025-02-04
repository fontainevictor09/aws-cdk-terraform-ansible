# Fournisseur AWS
provider "aws" {
  region = var.aws_region
}

terraform {
  backend "s3" {
    bucket         = ""
    key            = "terraform.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}