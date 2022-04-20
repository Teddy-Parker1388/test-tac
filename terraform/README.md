# TERRAFORM - Main Application Infrastructure
Application specific Terraform code goes here.

```{ATTENTION}
The terraform code in this directory should be seen and used as a starting place
for your application's infrastructure. Feel free to add to and modify it as needed.

However, please also be aware that some settings are required and that changing
those settings may result in a failed deployment. See below for more details.
```

This code should make use of the [Shared Terraform Modules](http://stash.cengage.com:7990/projects/TM) to do the heavy lifting.

## Required Files

### Auto-managed files
Any per environment or environment class changes to the files in this list are
automatically made by running the `tsunami app update` command for each environment.

* backend.tf
* main.tf
* shared/main.tf
* shared/variables.tf
* variables.tf

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
