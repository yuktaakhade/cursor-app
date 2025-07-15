variable "project_id" {}
variable "region" { default = "us-central1" }
variable "db_user" { default = "appuser" }
variable "db_password" {
  description = "The DB password"
  sensitive   = true
}
variable "github_org" {}
variable "github_repo" {}
variable "artifact_repo_name" {
  description = "Name of the Artifact Registry repository"
  default     = "eshop-docker-repo"
}
variable "workload_identity_pool_id" {
  description = "Name for the Workload Identity Pool"
  default     = "eshop-github-pool"
} 