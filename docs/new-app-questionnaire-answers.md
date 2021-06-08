# New App Questionnaire - Answers
This file is meant to serve as an example set of answers to the [New App Questionnaire](https://stash.cengage.com/projects/DO/repos/tsunami/browse/docs/new-app-questionnaire.md).

## The Answers

### General
1. What deployment environments does the app require?
    - dev, qa, stage, perf, prod

### AWS Account
1. What is your AWS account ID?
    * 520321385220
2. What is the Non-Prod VPC Id?
    * vpc-033457ff3832157ce
3. What is the Prod VPC Id?
    * vpc-0e56100c0a254597a
4. What are the App tier sub-nets per VPC?
    * Non-Prod
        - subnet-03e15add9f3323400
        - subnet-02e05c354a15c539e
        - subnet-02d2e77cb1c91d326
        - subnet-009ef5977885af3b8
        - subnet-0926931eb14fdf09c
    * Prod
        - subnet-019048a9b37a8a29b
        - subnet-0a01796138875fb5c
        - subnet-0d0eb6f1117fafaef
        - subnet-047551958d84b1f16
        - subnet-04b63579bf529736b
5. What are the Web tier sub-nets per VPC?
    * Non-Prod
        - subnet-05ef0c8153582b88c
        - subnet-0bb90dc98c1ab5177
        - subnet-0a608416ec283df42
        - subnet-0273b960fbf48fe95
        - subnet-02b0466e358f3238c
    * Prod
        - subnet-03ed18c5fd67bdfdf
        - subnet-05c51f58a4f024162
        - subnet-0b5738489b75b9af2
        - subnet-057a292571cff2f1f
        - subnet-0113be34508ea2aaa

### app.yml
1. What's the name of your application?
    * tsunami-ref-app
2. Where on the filesystem should your application be installed?
    * /opt/tsunami-ref-app
3. What user & group will be used to run your application?
    * user: web; group: web
4. What log files you would like ingested by Splunk.
    * /opt/tsunami-ref-app/logs/request.log
        - Index: devops_prod_logs
        - Sourcetype: tsunami-ref-app-dev

### config.yml
1. What configuration files does you application need?
    * tsunami-ref-app.service
        - path: /etc/systemd/system
        - example/template: N/A. Use Generic.
    * default.json
        - path: /opt/tsunami-ref-app/conf
        - example/template: https://stash.cengage.com/projects/DO/repos/tsunami-ref-app/browse/conf/default.json
        - user/group: web:web
        - perms: 0644
        - Per Env:
          - params: port
          - secrets: code_phrase
2. Secrets will need to be added to Vault.
    * DONE. See `secret/applications/ENV/tsunami-ref-app/default.json
3. Does your application require it's own systemd unit file for startup?
    * YES
    * `ExecStart=/bin/node /opt/tsunami-ref-app/server.js`

### os.yml
1. What OS does your application need?
    * CentOS7 (b/c it's the only OS currently supported.)
2. Does your application require any specific `ulimits` to be set?
    * web
        - limitnofile: 40000
        - limitnproc: 32768
        - limitmemlock: 70000

### harness/bootstrap.yml
1. Where do the artifacts for your application live?
      * Artifactory
      * Path: com/cengage/devops/tsunami-ref-app
2. What Jenkins jobs should be run for deployment verification?
    * Smoke Tests
        - DevOps/tsunami-ref-app-smoke
        - Params:
            - url
        - Envs: dev, qa, stage, perf, prod
    * Contract Tests
        - DevOps/tsunami-ref-app-contract
        - Params:
            - url
        - Envs: qa, stage, prod
    * Performance Tests
        - DevOps/tsunami-ref-app-performance
        - Params:
            - url
        - Envs: perf
3. What additional deployment verification does your app require?
    * DynaTrace: 
        - stage: SERVICE-A147C795226180AC
        - perf: SERVICE-D65BDE8E522F5800
        - prod: SERVICE-156452F3E3321BEF
    * Splunk:
        - stage: index=devops_prod_logs sourcetype="tsunami-ref-app-stage" \[ERROR\]
        - perf: index=devops_prod_logs sourcetype="tsunami-ref-app-perf" \[ERROR\]
        - prod: index=devops_prod_logs sourcetype="tsunami-ref-app-prod" \[ERROR\]
4. Should we enable 24/7 Service Guard in Harness for your Application?
     * Yes: Splunk & Dynatrace
5. ServiceNow / RFC Related
   * item: CD-DevOps
   * Subcategory: Internal Application

### platform.yml
1. What platform or tech stack does your application require?
    * NodeJS v12.18.0

### system.yml
1. What additional users and/or groups should be created?
    * Groups
        - web
    * Users (username:default_group)
        - web:web

### ansible
1. Does your application require any application specific Ansible code to be run during the image building process?
    * No

### packer
1. To which product group does your application belong?
    * DevOps

### terraform
1. What is the Role ARN for the S3 state storage backend?
    * Shared via LastPass
2. What [instance type](https://aws.amazon.com/ec2/instance-types/) does your application require?
    * t2.micro
3. What are the Min, Max and Desired instance counts?
    * Min: 1
    * Max: 2
    * Desired: 2
4. Does your application require any dependent resources, i.e. Redis, Databases, etc.?
    * Yes. Example code to demonstrate dependent terraform usage and outputs.
    * Outputs
        - db_password
        - api_token
