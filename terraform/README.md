# terraform
Application specific Terraform code goes here.

This code should make use of the [Shared Terraform Modules](http://stash.cengage.com:7990/projects/TM) to do the heavy lifting.

## Required Files
### main.tf
The following items need to be changed per environment:

* `terraform.backend.key`: `<AWS_ACCOUNT_ID>/<APP_PROD-NON_PROD>/<ENV>.tfstate`
* `terraform.backend.role_arn`: `arn:aws:iam::<IAM_ID>:role/<APP_PROD-NON_PROD>`

<!-- TODO: update me  -->
### variables.tf
The following items need to be changed per environment:

* `vpc_id`: VPC Id for the environment.
* `subnets`: Web tier subnests for the environment.
* `instance_type`: EC2 instance type to use for the environment.

### outputs.tf
Certain outputs are required so that the application can be set up and deployed
by Harness.

* region: AWS Region
* autoscaling_group_name - Necessary for Blue/Green deployments
* alb_target_groups  - Necessary for Blue/Green deployments
* stage_target_group - Necessary for Blue/Green deployments
* alb_dns_name_public - Public host name.
* alb_dns_name_private - Private host name. Passed to smoke/contract/load tests during a Blue/Green deployment.

## Dependencies
It is possible to use Terraform to construct resources that your application depends on.
This includes building things like databases or Redis clusters.

Terraform code of this type lives in the `terraform/dependencies` directory.

See the [README.md](./dependencies/README.md)
