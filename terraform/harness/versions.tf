terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = ">=0.26.0"

    }

    vault = {
      source  = "hashicorp/vault"
      version = ">=3.17.0"
    }
  }
}