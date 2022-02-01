// -----------------------------------------------------------------------------
// ***** NOTE *****
// All variables in this file are shared by the "main" terraform code and the 
// "dependencies" terraform code.
// 
// Don't add any variables to this file that are specific to one or the other.
// Instead add the specific variables to the 'variables.tf' file for the 
// appropriate terraform code set.
// -----------------------------------------------------------------------------
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

// TODO: 'subnet_prefix' should match the prefix of each subnet as seen in the
//       AWS console.
//       Format: <prefix>-<env_type>-<tier>-<region-az>
//       Example: devops-non-prod-app-tier-us-east-1
//       ...so prefix in this case is 'devops'...
variable "subnet_prefix" {
  default     = "devops"
  description = "The prefix of each subnet name"
}

// TODO: VPC_ID: Must change value to reflect VPC for environment.
variable "vpc_id" {
  default     = "vpc-05888f065bca4b7d1"
  description = "The deployment VPC on AWS."
}
