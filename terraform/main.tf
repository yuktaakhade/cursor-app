locals {
  region     = var.region
  project_id = var.project_id
}

module "vpc" {
  source = "./modules/vpc"
  name   = "gke-network"
  cidr   = "10.10.0.0/16"
  region = local.region
}

module "iam" {
  source       = "./modules/iam"
  account_id   = "gke-sa"
  display_name = "GKE Service Account"
  roles        = [
    "roles/container.admin",
    "roles/compute.networkAdmin",
    "roles/iam.serviceAccountUser"
  ]
  project_id = local.project_id
}

module "gke" {
  source     = "./modules/gke"
  name       = var.gke_cluster_name
  location   = var.gke_location
  network_id = module.vpc.network_id
  subnet_id  = module.vpc.subnet_id
  project_id = local.project_id
}

resource "google_project_service" "services" {
  for_each = toset([
    "container.googleapis.com",
    "compute.googleapis.com",
    "iam.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "artifactregistry.googleapis.com"
  ])
  service = each.key
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "docker_repo" {
  location      = local.region
  repository_id = "gke-docker-repo"
  format        = "DOCKER"
  depends_on    = [google_project_service.services]
}

resource "google_service_account" "github_actions" {
  account_id   = "github-actions-cicd"
  display_name = "GitHub Actions CI/CD Service Account"
}

resource "google_project_iam_member" "github_actions_roles" {
  for_each = toset([
    "roles/artifactregistry.writer",
    "roles/container.developer"
  ])
  project = local.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.github_actions.email}"
}

output "gke_endpoint" {
  value = module.gke.endpoint
}

output "gke_cluster_name" {
  value = module.gke.name
}

output "gke_ca_certificate" {
  value = module.gke.ca_certificate
}

output "artifact_registry_repo" {
  value = google_artifact_registry_repository.docker_repo.repository_id
}

output "github_actions_service_account_email" {
  value = google_service_account.github_actions.email
} 