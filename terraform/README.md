# terraform
Application specific Terraform code goes here.

-----

**NOTE**
The terraform code in this directory should be seen and used as a starting place
for your application's infrastructure. Feel free to add to and modify it as needed.
However, please also be aware that some settings are required and that changing
those settings may result in a failed deployment. See below for more details.

-----

This code should make use of the [Shared Terraform Modules](http://stash.cengage.com:7990/projects/TM) to do the heavy lifting.

## Required Files
### backend.tf
The following items need to be changed per environment:

* `terraform.backend.key`: `<AWS_ACCOUNT_ID>/<APP_PROD-NON_PROD>/<ENV>.tfstate`
* `terraform.backend.role_arn`: `arn:aws:iam::<IAM_ID>:role/<APP_PROD-NON_PROD>`

### main.tf
Look for `TODO`s in the file for required changes.

### shared/main.tf
Look for `TODO`s in the file for required changes.

### shared/variables.tf
The following items need to be changed per environment:

* `vpc_id`: VPC Id for the environment.

Look for `TODO`s in the file for other required changes.

### variables.tf
The following items need to be changed per environment:

* `instance_type`: EC2 instance type to use for the environment.

Look for `TODO`s in the file for other required changes.

### outputs.tf
Certain outputs are required so that the application can be set up and deployed
by Harness.

All outputs currently in `outputs.tf` are required. You may add additional
`output` statements, but do not remove any.

## Dependencies
It is possible to use Terraform to construct resources that your application depends on.
This includes building things like databases or Redis clusters.

Terraform code of this type lives in the `terraform/dependencies` directory.

See the [README.md](./dependencies/README.md)

### dependencies/backend.tf
The following items need to be changed per environment:

* `terraform.backend.key`: `<AWS_ACCOUNT_ID>/<APP_PROD-NON_PROD>/<ENV>.tfstate`
* `terraform.backend.role_arn`: `arn:aws:iam::<IAM_ID>:role/<APP_PROD-NON_PROD>`
