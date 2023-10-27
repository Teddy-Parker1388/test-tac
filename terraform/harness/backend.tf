terraform {
  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    dynamodb_table = "terraform-lock"
    region         = "us-east-1"
    encrypt        = true
    key            = "901254650597/devops-non-prod/mostly-harmless/harness-project.tfstate"
    assume_role = {
      role_arn = "arn:aws:iam::084140270005:role/devops-non-prod"
    }

  }

}