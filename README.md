# mostly-harmless
Earth: Mostly Harmless.

The Tsunami Reference Application for In-Place deployments.

This application is meant to serve as documentation on how to set up and use a
Tsunami Application Config repository as well as being a working application that
can be deployed and used for Tsunami development and testing purposes.

## Variables
Image build time vs. Deployment Time

* `ansible_host`
  - Defined during image build, BUT will NOT be the hostname/ip of the actual instance.
  - Will be the hostname/ip of the instance being used to build the image.
  - I.e. Don't count on it being correct on the image.
* `tsunami_node_id`
  - NOT defined during image build
  - IS defined during the `deploy in-place` process

-----

Documentation on setting up and using a TAC repo can be found [here](https://stash.cengage.com/projects/TAC/repos/tsunami-ref-app/browse/docs/config-usage.md).
