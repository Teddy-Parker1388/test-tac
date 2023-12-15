/* This file is auto-generated. */
/* Any manual changes will be overwritten by the [tsunami harness sync] command. */
organization_id = "DevOps"
project_vars = {
  ProductGroup   = "DevOps"
  RFCItem        = "CD-DevOps"
  RFCSubCategory = "Internal Application"
}
project_name                  = "mostly-harmless"
deployment_type               = "in-place"
is_test_project               = true
build_infra_deps              = true
environments                  = ["dev", "qa", "stage", "perf", "prod"]
artifact_server               = "artifactory_cengage_maven"
artifact_format               = "ZIP"
artifact_filter               = "com/cengage/devops/mostly-harmless/**/*.zip"
snapshots_source              = "cengage-snapshots"
releases_source               = "cengage-releases"
user_group_team_name          = "DevOps Team"
user_group_team               = ["craig.caroon@cengage.com", "teddy.parker@cengage.com", "nick.sansone@cengage.com", "haripriya.maddineni@cengage.com"]
user_group_notifications_name = "DevOps Notifications"
user_group_notifications      = ["ben.stewart@cengage.com", "craig.caroon@cengage.com", "teddy.parker@cengage.com", "nick.sansone@cengage.com", "haripriya.maddineni@cengage.com"]
jenkins_tests                 = <<-EOF
jenkins:
  - name: Functional Tests
    job: mostly-harmless/Functional Tests
    environments:
      - dev
      - qa
      - stage
      - perf
      - prod
    params:
      - name: url
        value: https://<+pipeline.stages.Build_Infra_Main.spec.execution.steps.Infrastructure.steps.Terraform_Apply.output.alb_dns_name_private>:8443
      - name: env
        value: <+env.name>
  - name: Contract Tests
    job: CCaroon/Harness Test Job
    environments:
      - dev
      - qa
      - stage
      - perf
      - prod
    params:
      - name: name
        value: Contract Tests
      - name: url
        value: https://<+pipeline.stages.Build_Infra_Main.spec.execution.steps.Infrastructure.steps.Terraform_Apply.output.alb_dns_name_private>:8443
      - name: env
        value: <+env.name>
      - name: force_fail
        value: false
  - name: Load Tests
    job: mostly-harmless/Load Tests
    environments:
      - stage
      - perf
    params:
      - name: url
        value: https://<+pipeline.stages.Build_Infra_Main.spec.execution.steps.Infrastructure.steps.Terraform_Apply.output.alb_dns_name_private>:8443
      - name: env
        value: <+env.name>
      - name: duration
        value: 60
EOF
