# terraform/dependencies
Terraform code to configure application dependencies lives here.

This can include setting up databases, kv stores (redis) and the like.
Outputs from this terraform code may be used in your configuration files.

## Required Files
### backend.tf
The following items need to be changed per environment:

* `terraform.backend.key`: `<AWS_ACCOUNT_ID>/<APP_PROD-NON_PROD>/<ENV>.tfstate`
* `terraform.backend.role_arn`: `arn:aws:iam::<IAM_ID>:role/<APP_PROD-NON_PROD>`

### main.tf
The main terraform code to create your dependencies.

Look for `TODO`s in the file for required changes.

### ../shared/main.tf
Terraform code shared between the "main" and "dependencies" terraform code sets.

### variables.tf
Look for `TODO`s in the file for required changes.

### ../shared/variables.tf
Terraform variables shared between the "main" and "dependencies" terraform code sets.

### outputs.tf
The terraform resource outputs that you'd like to make available to your application
configuration files.

These outputs are available to your config files via the `shared_params` variable.
