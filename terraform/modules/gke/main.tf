variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "location" {
  description = "The zone for the GKE cluster (e.g., us-central1-c)"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "e-shopping-cluster"
}

variable "network" {
  description = "The name of the VPC network to use"
  type        = string
}

variable "subnetwork" {
  description = "The name of the subnetwork to use"
  type        = string
}

resource "google_service_account" "gke_nodes" {
  account_id   = "gke-nodes"
  display_name = "GKE Nodes Service Account"
  project      = var.project_id
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.location
  project  = var.project_id

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.network
  subnetwork = var.subnetwork

  ip_allocation_policy {}
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool"
  cluster    = google_container_cluster.primary.name
  location   = var.location
  project    = var.project_id

  node_count = 1

  node_config {
    machine_type   = "e2-medium"
    service_account = google_service_account.gke_nodes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
} 