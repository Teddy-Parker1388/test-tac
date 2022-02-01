// -----------------------------------------------------------------------------
// See Also: shared-main.tf
// -----------------------------------------------------------------------------
terraform {
  backend "s3" {
    bucket         = "cengage-shared-terraform-backend"
    dynamodb_table = "terraform-lock"
    region         = "us-east-1"
    encrypt        = true
    // TODO: 'key' **must** be updated to reflect account, app and environment
    // => <account_id>/<account_name>/<application>/deps/<env>.tfstate
    key = "901254650597/devops-non-prod/mostly-harmless/deps/dev.tfstate"
    // TODO: 'role_arn' **must** be update to reflect non-prod / prod account
    // => arn:aws:iam::084140270005:role/<account_name>
    role_arn = "arn:aws:iam::084140270005:role/devops-non-prod"
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
