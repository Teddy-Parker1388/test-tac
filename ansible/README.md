# ansible
Application specific Ansible code goes here, if any! It's perfectly acceptable
for this directory to be empty.

## Organization
Ansible code defined here **must** be organized as one or more [Ansible Roles](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_reuse_roles.html).

## Execution
The roles defined here will be executed in ASCII'betical order (think string sort).

The roles will be executed as part of the image building/provisioning process
**after** all other application provisioning is complete.

Failures in your ansible code will cause the image building process to fail.

### Example
This TAC repo defines two Ansible Roles:
- example-one
- example-two

After all the default image provisioning has completed, "example-one" will be
executed first (since it string sorts before "example-two"), then "example-two"
will be executed next.

## Restrictions
The Tsunami Image building code can build images for Docker, Vagrant and AWS.

If your ansible code will be executing tasks that are specific to one or more of
these formats, please write your code in such as way that those tasks are excluded
from running on the incompatible formats. To accomplish this you can use the
`packer_builder_type` variable coupled with `when` statements.

Valid Values for `packer_builder_type`:
* docker
* vagrant
* amazon-ebs

For example:
```yaml
# Only run for Vagrant images (boxes)
- name: Install Guest Additions
  package:
     name: vbox-guest-additions
     state: present
  when: packer_builder_type == 'vagrant'
```
