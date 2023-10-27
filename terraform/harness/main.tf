module "project" {
  source                        = "git::ssh://git@stash.cengage.com:7999/do/harness-terraform.git//modules/terraform-harness-project?ref=master"
  organization_id               = var.organization_id
  project_name                  = var.project_name
  is_test_project               = var.is_test_project
  environments                  = var.environments
  artifact_format               = var.artifact_format
  artifact_server               = var.artifact_server
  artifact_filter               = var.artifact_filter
  snapshots_source              = var.snapshots_source
  releases_source               = var.releases_source
  user_group_notifications_name = var.user_group_notifications_name
  user_group_team_name          = var.user_group_team_name
  user_group_notifications      = var.user_group_notifications
  user_group_team               = var.user_group_team
  build_infra_deps              = var.build_infra_deps
  jenkins_tests                 = var.jenkins_tests
  project_vars                  = var.project_vars
  deployment_type               = var.deployment_type

}
