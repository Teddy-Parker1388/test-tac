// -----------------------------------------------------------------------------
// See Also: shared-main.tf
// -----------------------------------------------------------------------------
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "api_token" {
  length  = 32
  special = false
}

// -- Load Necessary Subnet Ids --
// ** Uncomment to load DB tier subnet ids. **
// data "aws_subnets" "database" {
// filter {
//    name   = "vpc-id"
//    values = [var.vpc_id]
//  }
//   tags   = { Name = "*-${local.env_type}-db-tier*" }
// }

// // ** Uncomment to load App tier subnet ids. **
// data "aws_subnets" "app" {
// filter {
//    name   = "vpc-id"
//    values = [var.vpc_id]
//  }
//   tags   = { Name = "*-${local.env_type}-app-tier*" }
// }

// -- Provide S3 Support --
// ** Uncomment to Provision S3 Bucket 

// locals {
//   iam_policy_statement = {
//     Version = "2012-10-17"
//     Statement = [ ]
//   }

//  iam_role_statement = {
//     Version = "2012-10-17"
//     Statement = [ ]
//   }

//}

// module "s3" {
//  source = "git::ssh://git@stash.cengage.com:7999/tm/terraform-aws-s3-extended.git"

// ** S3 Bucket **
// create_s3_bucket = true 
// bucket_to_create = {
//   bucket = "${var.app_name}-${var.app_env}"
//   bucket_prefix = var.bucket_prefix
//   force_destroy = true | false
//   object_lock_enabled = true | false 
// }
// tags = local.common_tags

// ** S3 Bucket Versioning **
// create_bucket_versioning = true | false
// versioning_configuration = {
// status = var.s3_bucket_versioning_status
// mfa_delete = var.s3_bucket_versioning_mfa_delete
//      }
// mfa = var.s3_bucket_versioning_mfa           

// ** Serverside Encryption **
// create_server_side_encryption = true | false
// sse_rule = {
// kms = var.s3_bucket_serverside_encryption_kms
// sse = var.s3_bucket_serverside_encryption_sse
// }

// ** Bucket Ownership Controls **
// create_ownership_controls = true | false
// object_ownership = var.s3_bucket_object_ownership

// ** S3 Bucket  Access Control List **
// create_bucket_acl = true | false
// acl = var.s3_bucket_acl  

// ** IAM Policy for S3 Access **
// create_iam_policy = true | false
// s3_iam_policy_name = "${var.app_name}-s3-policy-${var.app_env}"
// s3_iam_policy_statement = local.iam_policy_statement     // Map object defining the IAM Policy Statement

// ** IAM Role for the inline IAM Policy
// create_iam_role = true | false
// s3_iam_role_name = "${var.app_name}-s3-role-${var.app_env}"
// s3_iam_role_policy = local.iam_role_statement


// ** IAM Instance Profile **
// create_instance_profile = true | false 
// instance_profile_name = "${var.app_name}-s3-role-${var.app_env}"

// }


// -- Provide EFS Support --
// ** Uncomment to Provision EFS File System

/* locals {
//  efs_ingress = [{
//    port = 80
//    protocol = ""
//    cidr = []
//  }]

//  efs_engress = [{
//    port = 80
//    protocol = ""
//    cidr = []
//  }]

//   efs_policy =<<POLICY
//        {
//             "Version" : "2012-10-17",
//              "Statement" : [ ]
//          }
//            POLICY

}
*/

/*
module "efs" {

// source = "ssh://git@stash.cengage.com:7999/tm/terraform-aws-efs.git"

// ** EFS File System **
// efs_perf_mode = var.efs_performance_mode
// creation_token = "${var.app_name}_${var.app_env}_services"    
// encrypt = true | false 
// throughput_mode = var.efs_throughput_mode
// kms_key_id = var.efs_kms_key_id
// transition_to_ia = var.efs_transition_to_ia
// efs_tags = local.common_tags

// ** Security Groups for EFS File System **
// create_security_group = true | false
// efs_sec_grp_name = "${var.app_name}-efs"
// efs_sec_grp_desc = "${var.app_name} EFS SG"
// efs_ingress = local.efs_ingress 
// efs_egress = local.efs_egress
// vpc_id = var.vpc_id


// ** EFS  Mount Targets **
// subnets = data.aws_subnets.app.ids
// efs_security_group_ids = []       // REQUIRED if create_security_group = false  

// ** EFS File System Policy ** 
// create_efs_policy = true | false 
// efs_policy = local.efs_policy

}
*/


// -- Provide EFS Support --
// ** Uncomment to Provision RDS

// -- Uncomment data block to query secrets for database username and password --
/*
data "vault_generic_secret" "db" {
  path = ""        // Enter path to secret
}
*/

// -- Uncomment locals block to use ingress and egress values in db security group  --
/*
locals{

  rds_ingress = [{
    port = 0
    protocol = ""
    cidr = []
 }]

  rds_egress = [{
    port = 0
    protocol = ""
    cidr = []
  }]

}
*/

/*
module "rds" {
  source = "ssh://git@stash.cengage.com:7999/tm/terraform-aws-rds.git"

// ** RDS Database **
//  create_rds_cluster = true | false     // true,creates RDS Cluster and Cluster Instance | false, creates DB Instance
//  rds_cluster_identifier = "${var.app_name}-rds-cluster-${var.app_env}"     // REQUIRED if create_rds_cluster = true

//  identifier = "${var.app_name}-rds-instance-${var.app_env}"
//  database_name = "${var.app_name}"
//  engine = var.db_engine
//  engine_version = var.db_engine_version
//  instance_class = var.db_instance_class
//  allocated_storage = var.db_allocated_storage
//  master_username = data.vault_generic_secret.db.data["db_username"]
//  master_password = data.vault_generic_secret.db.data["db_password"]
//  port = var.db_port
//  apply_immediately = true | false
//  deletion_protection = true | false
//  skip_final_snapshot = true | false
//  vpc_security_group_ids = []   // REQUIRED if create_security_group = false 


// ** Time in UTC **
//  maintenance_window = "sat:04:00-sat:12:00"
//  back_up_window = "00:00-04:00"
//  backup_retention_period = 7

// ** DB Subnet Group **
// create_subnet_grp = true | false
// db_subnet_group_description = "Subnet Group Description"
// use_subnet_group_name_prefix = true | false
// db_subnet_group_name = "db_subnet_group_name"
//db_subnet_group_name_prefix = "db_subnet_group_name_prefix"
// subnet_ids = data.aws_subnets.database.ids

// ** Security Group **
// create_security_group = true | false
// rds_sec_grp_name = "security_group_name"
// rds_sec_grp_desc = "Security Group Description"
// vpc_id = var.vpc_id
// rds_ingress = local.rds_ingress
// rds_egress = local.rds_egress

// ** DB Parameter Group **
// create_db_param = true | false
// use_db_parameter_group_name_prefix = true | false
// db_parameter_group_name_prefix = "parameter_group_name_prefix"
// db_parameter_group_name = "parameter_group_name"
// db_parameter_group_description = "Parameter Group Description"
// family = var.db_family


// ** DB Option Group **
// create_db_option = true | false
// use_db_option_group_name_prefix = true | false
// db_option_group_name = "db_option_group_name"
// db_option_group_name_prefix = "db_option_group_name_prefix"
// major_engine_version = var.db_major_engine_version


// all_tags = local.common_tags

}
*/