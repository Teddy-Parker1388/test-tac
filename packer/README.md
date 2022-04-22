# PACKER - Application Specific Packer Code
Application specific Packer code goes here.

## Required Files
### vars.json
Required Settings:
* `app`: Your Application's Name
* `product`: Your Application's Product Group

Optional Settings:
* `docker`: Used to specify changes to the Docker image metadata.
  - For example, it can be use to set an ENTRYPOINT for your application.
  - See [Docker Builder](https://www.packer.io/docs/builders/docker#basic-example-changes-to-metadata)
