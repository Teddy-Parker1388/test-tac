# Harness Terraform Code
The terraform code in this directory is used to create & update your application in Harness.

In general, only the Tsunami Team will be updating these files and applying any changes.

```{ATTENTION}
Although these terraform files exist on every environment branch of this repo, **ONLY** the versions located in the `dev` branch are used.

The Application in Harness **DOES NOT** need to be created for every environment.

Creating the Application from the `dev` branch terraform files creates all the resources necessary to deploy to every environment.
```

## General Workflow
1. `tsunami harness tf-sync`
2. Authenticate with AWS
3. Authenticate with Vault and set your `VAULT_TOKEN` env variable.
4. `cd terraform/harness`
5. `terraform init -upgrade`
6. `terraform plan`
7. Verify changes based on the plan output
8. `terraform apply`
9. Commit any source code changes via a Pull Request.