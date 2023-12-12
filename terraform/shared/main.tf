#|############################################################################|#
#| ***WARNING***  ***WARNING***   ***WARNING***   ***WARNING***  ***WARNING***|#
#|############################################################################|#
#| The contents of this file have been automatically updated by Tsunami
#| You **can** manually edit this file.
#|
#| However, be aware that the next time Tsunami updates this file you will loose
#| some formatting and all in-line comments. Header comments at the beginning of
#| the file will be preserved.
#|
#| Running `terraform fmt` will correct formatting issues.
#|############################################################################|#
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
  required_version = "~> 1.6"
  required_providers {
    aws = "5.28"
  }
}

locals {
  env_name = trimsuffix(var.app_env, "-${var.app_cluster}")
  env_type = local.env_name == "prod" ? "prod" : "non-prod"
  app_id   = trimsuffix("${var.app_name}-${local.env_name}-${var.app_cluster}", "-")
  common_tags = {
    Name            = local.app_id
    Product         = var.app_product
    App             = var.app_name
    Environment     = local.env_name
    Cluster         = var.app_cluster
    app-platform    = "${var.app_name}-${var.app_cluster}"
    app-environment = local.env_name
    app-service     = var.app_runtime
  }
}
