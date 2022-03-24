# ansible
Application specific Ansible code goes here, if any! It's perfectly acceptable
for this directory to be empty.

-----

**NOTE**
You SHOULD delete all the files and directories in this directory as they are just
examples and are NOT relevant to your application.

-----

Tsunami will look for specially named files in this directory and execute them
at different points in the image build / deployment process.

## Task Files
This is a list of the special files that Tsunami will look for. If a file of the
given name exists, it will be executed as a set of Ansible tasks.

### artifact.yml
Tasks defined in `artifact.yml` will be executed directly after your artifact has
been installed.

If your application requires any post-artifact installation tasks to be execute,
this is where you would defined those tasks.

### main.yml
Tasks defined in `main.yml` will be executed after all other Tsunami tasks have
completed.

`main.yml` is a good place to define application specific tasks that are not
already taken care of by the built-in Tsunami tasks.

## Organization
Each task file can contain one or more Ansible tasks. 

If your Ansible code is not just a couple of simple tasks, you may want to consider
creating one or more [Ansible Roles](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_reuse_roles.html)
to accomplish your tasks and keep your code organized.

See `main.yml` in this repo for an example.

## Execution
The tasks & roles will be executed as part of the image building/provisioning 
process.

Failures in your ansible code will cause the image building process to fail.

### Example
This TAC repo defines two Ansible Roles:
- example-one
- example-two

The `main.yml` file executes each of these roles, using the `include_role` module,
and a couple of simple in-line tasks as well.

## Restrictions
The Tsunami Image building code can build images for Docker, Vagrant and AWS.

If your ansible code will be executing tasks that are specific to one or more of
these formats, please write your code in such as way that those tasks are excluded
from running on the incompatible formats. To accomplish this you can use the
`image_type` variable coupled with `when` statements.

Valid Values for `image_type`:
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
  when: image_type == 'vagrant'
```
