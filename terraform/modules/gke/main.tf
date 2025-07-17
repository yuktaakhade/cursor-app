resource "google_container_cluster" "this" {
  name     = var.name
  location = var.location

  network    = var.network_id
  subnetwork = var.subnet_id

  release_channel {
    channel = "REGULAR"
  }

  enable_autopilot = true

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  deletion_protection = false
}

output "endpoint" {
  value = google_container_cluster.this.endpoint
}

output "name" {
  value = google_container_cluster.this.name
}

output "ca_certificate" {
  value = google_container_cluster.this.master_auth[0].cluster_ca_certificate
} 