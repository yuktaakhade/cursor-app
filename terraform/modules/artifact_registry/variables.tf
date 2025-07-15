variable "project_id" {}
variable "region" {}
variable "repo_name" {
  description = "Name of the Artifact Registry repository"
  default     = "eshop-docker-repo"
} 