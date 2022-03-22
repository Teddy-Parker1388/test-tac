// -----------------------------------------------------------------------------
// See Also: shared-main.tf
// -----------------------------------------------------------------------------
resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "api_token" {
  length  = 32
  special = false
}
