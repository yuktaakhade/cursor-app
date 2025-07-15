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