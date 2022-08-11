# Getting Started

## Managing Environments
For each deployment environment you will need to have a branch of the Tsunami
Application Config repo named after the name of the environment.

Supported environments are:
* dev
* qa
* stage
* perf
* prod

```{TIP}
Tsunami does not require an application to have **all** of the supported environments.
You will only need to set up the environments that the application requires.
```

Environments are classified into two groups:
* Non-Prod
  - dev
  - qa
  - stage
  - perf
* Prod
  - prod

All non-prod environments share the same AWS Account, VPC and Subnets.

Production will have a different AWS Account, VPC and Subnets.

### Initial Environment
Start with the `dev` environment & branch to get everything working.

```{TIP}
You don't have to start with `dev` if a DEV environment is not suitable for the
application. It's ok if `qa` or `stage` is your first environment.
```

Basic guidance on grooming the provided TAC files to suit your application's need:

* Each of the YAML files is documented to help guide you on their usage.
* Be sure to read the various README files in the sub-directories.
* Update `app.yml`, `os.yml`, `platform.yml` and `system.yml`
* Application config files
  - Copy the application's config files to the `config/` directory
  - Templatize each config file. Try to make each config file a generic as
    possible. Use `params` & `secrets` for any values that are environment specific.
* Update `config.yml`
* Update `infrastructure.yml`
* Set `deployment_type` in `harness.yml`
* Commit the changes so far back to git.
* Run `tsunami tac sync`
  - This will update a few terraform and possibly other files
  - Verify the changes with `git diff`
  - If you update the `infrastructure.yml` file, be sure to re-run this command.
* Review the Terraform files in `terraform` and `terraform/dependencies`
  - You can remove the `terraform/dependencies` directory if you don't need it.
  - The initially provided Terraform code defines the basic infrastructure needed
    for the app's deployment type. This basic infrastructure may not be exactly
    suitable for your application.
  - Within certain bounds you may modify the Terraform code to suit your application's needs.
* Commit the changes.

### Additional Environments: qa | stage | perf | prod
```{CAUTION}
Don't create any additional branches/environments in the TAC repo until you have
had a successful deployment to your initial environment. This will save you the
trouble of having to modify files in more than one branch while you are trying 
to get the initial environment successfully deployed.

In general, don't create the next environment until the previous environment
has been successfully deployed.
```

Create the next branch/environment by branching the previous environment branch:

* dev -> qa
* qa -> stage
* stage -> perf
* perf -> prod

1. `bash> git checkout <ENV>`
2. `bash> git pull`
3. `bash> git checkout -b <NEXT-ENV>`

Next, run `tsunami tac sync`. This will update the necessary files to be specific
to the new branch/environment.

You will also need to update the following on an environment by environment basis:

* Config File Params
    - The `config.yml` file should be updated as necessary to modify the `params`
      for each config file to be specific to the new environment.
* Config File Secrets
    - Ensure that the necessary secrets are set in Vault for the new environment.
    - See the *Managing Secrets* section in [config/README.md](../config/README.md).

Follow these same general instruction for creating any additional environments
that the application needs.

### Environment Branch Maintenance
Once the full compliment of environment branches exists, you'll need to maintain
changes between each branch. 

In general changes should be made to the lowest environment, e.g. `dev`, then
tested via a Harness deployment.

Once the changes are verified/approved, you can propagate the changes to the next
environment up the hierarchy.

This can be done a couple of ways:

1. Manually make the changes to the next environment branch:
    - `git checkout <next-env>`
    - Make the changes manually
    - `git commit`
2. Merge the changes between environment branches:
    - `git checkout <next-env>`
    - `git merge <lower-env>`
    - Resolve any conflicts that arise
    - `git commit`

Using Method #2 will give you better consistency between environment branches.
