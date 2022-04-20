# TERRAFORM - Dependency Infrastructure
Terraform code to configure infrastructure dependencies lives here.

This can include setting up databases, kv stores (redis) and the like.
Outputs from this terraform code may be used in your configuration files.

```{ATTENTION}
A basic Tsunami Application does not require any dependency Terraform code.

The Terraform code in this directory is an example of using this feature. If your
application does not require any dependent terraform code/infrastructure, then 
you should delete this `dependencies/` directory.
```

## Required Files
### backend.tf
Any per environment or environment class changes are automatically made by 
running the `tsunami app update` command for each environment.

### main.tf
The main terraform code to create your main infrastructure dependencies.

### ../shared/main.tf
Terraform code shared between the "main" and "dependencies" terraform code sets.

### variables.tf
You may defined any variables required by your dependency code.

### ../shared/variables.tf
Terraform variables shared between the "main" and "dependencies" terraform code sets.

### outputs.tf
The terraform outputs that you'd like to make available to your application
configuration files.

These outputs are available to your config files via the `shared_params` variable.
