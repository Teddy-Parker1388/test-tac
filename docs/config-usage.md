# Tsunami Application Config
TAC for short. Each TAC repo represents an application & deployment pipeline
configuration for an application running on the Tsunami Deployment Pipeline.

## Application Setup Files
### app.yml
Application specific settings. Things like the name of the application, the path
it should be installed to and logs that should be ingested by Splunk can be 
specified here.

[More Details](../app.yml)

### config.yml
Used to list all the configuration files required by the application.

[More Details](../config.yml)

### os.yml
Used to set the operating system for the application as well as several other
OS level settings.

[More Details](../os.yml)

### harness/bootstrap.yml
Settings needed to be able to create your App in Harness. This includes how to identify
the artifact in the artifact store, defining the Jenkins jobs and a few settings
relevant to the RFC process.

[More Details](../harness/bootstrap.yml)

### platform.yml
Used to set the runtime platform for the application. Platform in this sense refers
to the technology stack that the application needs to run, e.g. Java, NodeJS, etc.

[More Details](../platform.yml)

### system.yml
Used to specify system level settings. Meaning settings that aren't specically
related to the application or the OS. Includes things like Users and Groups that
should exist on the system.

[More Details](../system.yml)

## Sub Dirs
### ansible
See the [README.md](../ansible/README.md)

### config
See the [README.md](../config/README.md)

### packer
See the [README.md](../packer/README.md)

### terraform
See the [README.md](../terraform/README.md)

## Managing Environments
For each deployment environment you will need to have a branch of your application config repo with the environment name.

Supported environments are: 
* dev
* qa
* stage
* perf
* prod

Environments are classified into two groups:

* Non-Prod
  * dev
  * qa
  * stage
  * perf
* Prod
  * prod

All non-prod environments share the same AWS VPC and Subnets.
Production will have a different VPC and Subnets.

### First Non-Prod: dev
Start with a `dev` branch and environment to get everything working. Next move to another non-prod environment like `qa` or `stage`.

Use this Tsunami Application Config repo as a template for the necessary files and settings.

Task List:

* [ ] Change `tsunami-ref-app` everywhere to your application's name
* [ ] Change the product group, `DevOps`, everywhere to your application's group.
* [ ] VPC, Subnets and Instance type should be updated.
* [ ] `terraform/main.tf` --> `terraform.backend.key` should be updated.
* [ ] Update: `app.yml`, `config.yml`, `os.yml`, `platform.yml` and `system.yml`
* [ ] Add necessary config files in the `config` directory.
* [ ] ????

### Additional Non-Prod: qa | stage | perf (as needed)
Create the second non-prod branch/environment by branching your `dev` branch.

* `bash> git checkout dev`
* `bash> git checkout -b qa`

Next, update the necessary files as required. See information in this file and the `packer` and `terraform` README's for more information about required files and variables.

You will also need to update the following on an environment by environment basis:

* Config Params
    - The `config.yml` file should be updated as necessary to update config file parameters.
* Secrets
    - Ensure that the necessary secrets are set in Vault for each non-prod environment you use.
    - See the *Managing Secrets* section in [config/README.md](../config/README.md).
* VPC and Subnets
    - Ensure that the VPC Id and Subnet Ids in the following files are set for the non-prod environment:
        - `terraform/variables.tf`
        - `packer/vars.json`

### Prod
Create the `prod` branch/environment by branching one of your non-prod branches.

Next, update the necessary files as required. See information in this file and  the `packer` and `terraform` README's for more information about required files and variables.

You will also need to update the following for Production:

* Config Params
    - The `config.yml` file should be updated as necessary to update config file parameters.
* Secrets
    - Ensure that the necessary secrets are set in Vault for your Prod environment.
    - Again, see the *Managing Secrets* section in [config/README.md](../config/README.md).
* VPC and Subnets
    - Ensure that the VPC Id and Subnet Ids in the following files are set for the production environment:
        - `terraform/variables.tf`
        - `packer/vars.json`
