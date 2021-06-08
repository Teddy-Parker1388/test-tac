# terraform/dependencies
Terraform code to configure application dependencies lives here.

This can include setting up databases, kv stores (redis) and the like.
Outputs from this terraform code may be used in your configuration files.

## Required Files
### main.tf
The main terraform code to create your dependencies.

### outputs.tf
The terraform resource outputs that you'd like to make available to your application
configuration files.

These outputs are available to your config files via the `shared_params` variable.
