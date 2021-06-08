provider "aws" {
  region = var.region
}

terraform {
  required_version = "~> 0.13.0"

  required_providers {
    aws = "3.22.0"
  }

  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    key            = "901254650597/devops-non-prod/mostly-harmless/deps/dev.tfstate"
    dynamodb_table = "terraform-lock"
    role_arn       = "arn:aws:iam::084140270005:role/devops-non-prod"
    region         = "us-east-1"
    encrypt        = true
  }
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "api_token" {
  length  = 32
  special = false
}
