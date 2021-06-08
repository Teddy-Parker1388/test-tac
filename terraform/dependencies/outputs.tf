output "db_password" {
  description = "The Database(tm) Password"
  value       = random_password.db_password.result
  sensitive   = true
}

output "api_token" {
  description = "API Token for Jesu Rest API"
  value       = random_password.api_token.result
  sensitive   = true
}
