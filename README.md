# mostly-harmless
Earth: Mostly Harmless.

The Tsunami Reference Application for In-Place deployments.

## Variables
Image build time vs. Deployment Time

* `ansible_host`
  - Defined during image build, BUT will NOT be the hostname/ip of the actual instance.
  - Will be the hostname/ip of the instance being used to build the image.
  - I.e. Don't count on it being correct on the image.
* `tsunami_node_id`
  - NOT defined during image build
  - IS defined during the `deploy in-place` process
