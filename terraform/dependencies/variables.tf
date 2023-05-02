// -----------------------------------------------------------------------------
// See Also: shared-variables.tf
// -----------------------------------------------------------------------------
// 
// Dependent TF specific variables go in this file

// -- Provide S3 Support --
// ** Uncomment to Use Variables **
/*
variable "s3_bucket_object_ownership" {
  description = "Valid values: BucketOwnerPreferred, BucketOwnerEnforced, ObjectWriter "
  default = "BucketOwnerPreferred"
}

variable "s3_bucket_acl" {
  description = "Valid values: private, public-read"

}

variable "bucket_prefix" {
    description = "Prefix for bucket name"
    default = ""
}

variable "s3_bucket_serverside_encryption_sse" {
  description = "Valid values: AES256 , aws:kms"
  default = "AES256"
}

variable "s3_bucket_serverside_encryption_kms" {
  description = "KMS Key ID, when sse is aws:kms"
  default = null
}

variable "s3_bucket_versioning_status" {
  description = "Valid values Enabled,Disabled,Suspended"
  default = "Enabled"
}

variable "s3_bucket_versioning_mfa_delete" {
  description = "Valid values Enabled,Disabled"
  default = "Disabled"
}

variable "s3_bucket_versioning_mfa" {
  description = "MFA Serial Number. REQUIRED, if mfa_delete is `Enabled`"
  default = null
}

*/



// -- Provide EFS Support --
// ** Uncomment to Use Variables  **
/*
variable "efs_throughput_mode" {
  description = "Valid values: bursting, provisioned,elastic"
  default = "bursting"
}
variable "efs_performance_mode" {
  description = "Valid values: generalPurpose, maxIO"
  default = "generalPurpose"
  
}

variable "efs_security_group_description" {
  description = "Description of EFS Security Group"
  default=""
}

variable "efs_kms_key_id" {
  description = "When specifying kms_key_id , encrypted must be set to true"
  default = null
}

variable "efs_transition_to_ia" {
  default = "AFTER_90_DAYS"
}
*/

// -- Provide RDS Support --
// ** Uncomment to Use Variables  **
/*
variable "db_engine" {
  description = "Database engine"
}

variable "db_option_group_name_prefix" {
  description = "Prefix for DB Option Group Name"
  default = ""
}

variable "db_parameter_group_name_prefix" {
  description = "Prefix for DB Parameter Group Name"
  default = ""
}

variable "db_subnet_group_name_prefix" {
  description = "Prefix for DB Subnet Group Name"
  default = ""
}


variable "db_parameter_group_description" {
  description = "Description for DB Parameter Group"
  default = ""

}
variable "db_option_group_description" {
  description = "Description for DB Option Group"
  default = ""

}

variable "rds_security_group_description" {
  description = "Description of RDS Security Group"
  default=""
}

variable "db_subnet_group_description" {
  description = "Description of DB Subnet Group"
  default=""
}

variable "db_engine_version" {
  description = "Database engine version"
}

variable "db_instance_class" {
  description = "Database instance class"
}

variable "db_allocated_storage" {
  description = "Database storage allocation"
  type = number
}

variable "db_port" {
  description = "Database port"
  default = "3306"
}

variable "db_family" {
  description = "Db family"
}

variable "db_major_engine_version" {
  description = "Major engine version to be associated with option group"
}
*/