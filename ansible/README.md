# ANSIBLE - Application Specific Ansible
Application specific Ansible code goes here, if any! It's perfectly acceptable
for this directory to be empty.

```{ATTENTION}
You SHOULD delete all the files and directories in this directory as they are just
examples and are NOT relevant to your application.
```

Tsunami will look for specially named files in this directory and execute them
at different points in the image build / deployment process.

## Task Files - Entry Points
This is a list of the special files that Tsunami will look for. If a file of the
given name exists, it will be executed as a set of Ansible tasks.

### artifact.yml
Tasks defined in `artifact.yml` will be executed directly after your artifact has
been installed.

If your application requires any post-artifact installation tasks to be executed,
this is where you would defined those tasks.

### main.yml
Tasks defined in `main.yml` will be executed after all other Tsunami tasks have
completed.

`main.yml` is a good place to define application specific tasks that are not
already taken care of by the built-in Tsunami tasks.

## Variables
The following variables are defined and can be useful when writing application
specific Ansible.

* `app_<YAML_FILE>`
    - Your ansible code has access to all the values in all of the YAML
      files in your TAC repo. Each of the YAML files gets parsed into a variable
      named `app_<YAML_FILE>`. You can then reference values in those variables
      using dot notation.
    - Example: The `groups` value from the `system.yml` file can be accessed
               using `app_system.groups`
    - Availability: Image Build & Deploy Time
* `ansible_host`
    - Usage: For getting the hostname/ip of a specific instance.
    - Availability: Image Build (w/caveats) & Deploy Time
    - Image Build Caveats
      - Will be the hostname/ip of the instance being used to **build** the image.
      - Will NOT be the hostname/ip of the actual instance.
      - I.e. Don't count on it being correct on a running instance.
* `tsunami_node_id`
    - **In-Place Deployments Only**
    - Usage: Each instance/node in an in-place deployment is assigned a unique
             ID. You can access that unique ID using this variable.
    - NOT defined at Image Build time. Be sure to provide a default value.
    - Availability: Deploy Time
* `tsunami_action`
    - Usage: To determine if the ansible code is being run as part of an
             Image Build or a Deployment
    - Valid Values:
        + build
        + deploy
    - Availability: Image Build & Deploy Time
* `image_type`
    - Usage: To determine the type of image being built.
    - Valid Values:
        + docker
        + vagrant
        + amazon-ebs
    - Availability: Image Build & Deploy Time

## Organization
Each task file can contain one or more Ansible tasks. 

If your Ansible code is not just a couple of simple tasks, you may want to consider
creating one or more [Ansible Roles](https://docs.ansible.com/ansible/2.9/user_guide/playbooks_reuse_roles.html)
to accomplish your tasks and keep your code organized.

See `main.yml` in this repo for an example.

## Execution
The tasks & roles will be executed as part of the image building & deployment
process.

Failures in your ansible code will cause the execution to fail.

## Restrictions
The Tsunami Image building code can build images for Docker, Vagrant and AWS.

If your ansible code will be executing tasks that are specific to one or more of
these formats, please write your code in such as way that those tasks are excluded
from running on the incompatible formats. To accomplish this you can use the
`image_type` variable (described above) coupled with `when` statements.

For example:
```yaml
# Only run for Vagrant images (boxes)
- name: Install Guest Additions
  package:
     name: vbox-guest-additions
     state: present
  when: image_type == 'vagrant'
```

## Examples
See the YAML files and ansible roles in this directory for example usages.
