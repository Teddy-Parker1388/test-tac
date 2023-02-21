// -----------------------------------------------------------------------------
// ***** NOTE *****
// All code in this file is shared by the "main" terraform code and the 
// "dependencies" terraform code.
// 
// Don't add anything to this file that is specific to one or the other.
// Instead add the specific code to the 'main.tf' file for the appropriate
// terraform code set.
// -----------------------------------------------------------------------------
provider "aws" {
  region = var.region
}

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = "4.52"
  }
}

locals {
  env_type = var.app_env == "prod" ? "prod" : "non-prod"

  common_tags = {
    Name        = var.app_name
    Product     = var.app_product
    App         = var.app_name
    Environment = var.app_env
  }
}
