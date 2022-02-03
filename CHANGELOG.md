# CHANGELOG

## 2022-02-03
* Removed unneeded vars in `packer/var.json`
* Updated `harness/bootstrap.yml` to remove unneeded `aws` info
* Removed the need for the recently added `subnet_prefix` TF var

## 2022-02-02
* Added HTTPs support in terraform code.
  
## 2022-02-01
* Terraform code updates:
    - removed the need for hard-coded subnet ids.
    - removed the `data` entry for `aws_vpc.selected`...it was extraneous.
    - DRY'd up the code a bit by adding the `shared/*.tf` files.

## 2022-01-25
* Update app.yml to redirect logs to the Splunk `devops_nonprod_logs` index.

## 2022-01-20
* Terraform:
  - Added `TsunamiNodeId` to AWS Instance Tags
  - Added `inventory` to TF outputs
* Update `server.json` to make use of `tsunami_node_id` as a test

## 2021-10-12
* Updated terraform code to be 1.0 compliant

## 2021-07-26
* Added `config/server.json`
* Added `nodejs` to platform.yaml

## 2021-06-08
The Big Bang
