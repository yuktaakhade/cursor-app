variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The region for the Artifact Registry"
  type        = string
}

variable "repo_name" {
  description = "The name of the Artifact Registry repository"
  type        = string
}

resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google
  location      = var.region
  repository_id = var.repo_name
  description   = "Docker repository for e-shopping app"
  format        = "DOCKER"
}

output "repo_id" {
  value = google_artifact_registry_repository.docker_repo.id
} 