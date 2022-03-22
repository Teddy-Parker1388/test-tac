terraform {
  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    dynamodb_table = "terraform-lock"
    region         = "us-east-1"
    encrypt        = true
    // TODO: 'key' **must** be updated to reflect account, app and environment
    // => <account_id>/<account_name>/<application>/<env>.tfstate
    key = "901254650597/devops-non-prod/mostly-harmless/dev.tfstate"
    // TODO: 'role_arn' **must** be update to reflect non-prod / prod account
    // => arn:aws:iam::084140270005:role/<account_name>
    role_arn = "arn:aws:iam::084140270005:role/devops-non-prod"
  }
}
