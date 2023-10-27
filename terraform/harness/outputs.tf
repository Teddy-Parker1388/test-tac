output "dev_environment_attributes" {
  value = module.project.project_environments
}

output "start_stop_pipeline_id" {
  value = module.project.start_stop_pipeline_id
}

output "build_main_infra_pipeline_id" {
  value = module.project.build_main_infra_pipeline_id
}
output "project_tac_connector_url" {
  value = module.project.project_tac_connector_url
}

output "project_services_artifacts_id" {
  value = module.project.project_services_artifacts_id
}