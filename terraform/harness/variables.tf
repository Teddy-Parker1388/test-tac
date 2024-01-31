variable "organization_id" {
  type = string
}

variable "project_name" {
  type = string
}

variable "project_vars" {
  type = map(string)
}

variable "is_test_project" {
  type    = bool
  default = false
}

variable "environments" {
  type = list(string)
}

variable "artifact_server" {
  type = string
}

variable "artifact_format" {
  type    = string
  default = ""
}

variable "artifact_filter" {
  type    = string
  default = ""
}

variable "snapshots_source" {
  type    = string
  default = ""
}

variable "releases_source" {
  type    = string
  default = ""
}

variable "user_group_team" {
  type = list(string)
}

variable "user_group_notifications" {
  type = list(string)
}

variable "user_group_team_name" {
  type = string
}

variable "user_group_notifications_name" {
  type = string
}

variable "jenkins_tests" {
  type = string
}

variable "build_infra_deps" {
  type = bool
}

variable "deployment_type" {
  type = string
}

variable "files" {
  type    = map(string)
  default = {}
}

variable "start_stop_triggers_envs" {
  type    = list(string)
  default = []
}
