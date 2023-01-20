################################################################################
# => The contents of this file have been automatically updated by Tsunami <=
# You **can** manually edit this file.
#
# However, be aware that the next time Tsunami updates this file you will loose
# some formatting and all comments.
#
# Running `terraform fmt` will correct formatting issues.
################################################################################
terraform {
  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    dynamodb_table = "terraform-lock"
    region         = "us-east-1"
    encrypt        = true
    key            = "901254650597/devops-non-prod/mostly-harmless/dev.tfstate"
    role_arn       = "arn:aws:iam::084140270005:role/devops-non-prod"
  }

}
