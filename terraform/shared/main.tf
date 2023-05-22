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
  env_name = trimsuffix(var.app_env, "-${var.app_cluster}")
  env_type = local.env_name == "prod" ? "prod" : "non-prod"
  app_id   = trimsuffix("${var.app_name}-${local.env_name}-${var.app_cluster}", "-")

  common_tags = {
    Name            = var.app_name
    Product         = var.app_product
    App             = var.app_name
    Environment     = local.env_name
    Cluster         = var.app_cluster
    app-platform    = "${var.app_name}-${var.app_cluster}"
    app-environment = local.env_name
    app-service     = var.app_runtime
  }
}
