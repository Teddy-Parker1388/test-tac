# packer
Application specific Packer code goes here.

## Required Files
### vars.json
Required:
* `app`: Your Application's Name
* `product`: Your Application's Product Group
* `aws_vpc_id`: VPC Id for your team's AWS Account. 
* `aws_subnet_id`: App tier subnet Id in the above VPC for your team's AWS Account. 

Optional, but highly suggested:
* `aws_base_ami_id`: The base AMI to use when building AWS images.
  - If not specified, will default to the base AMI specified by our Packer code. In most cases this is a Marketplace AMI that will cause image builds to be slower.
  - It is **suggested** that this value be set to the Tsunami Base Image AMI Id for your application's AWS account & environment.
