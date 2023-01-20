################################################################################
# => The contents of this file have been automatically updated by Tsunami <=
# You **can** manually edit this file.
#
# However, be aware that the next time Tsunami updates this file you will loose
# some formatting and all comments.
#
# Running `terraform fmt` will correct formatting issues.
################################################################################
variable "region" {
  default = "us-east-1"
}

variable "app_name" {
  description = "Application Name"
  type        = string
  default     = "mostly-harmless"
}

variable "app_env" {
  description = "Application Deployment Environment"
  type        = string
}

variable "app_product" {
  description = "Application Product Group"
  type        = string
  default     = "DevOps"
}

variable "vpc_id" {
  default     = "vpc-05888f065bca4b7d1"
  description = "The deployment VPC on AWS."
}

