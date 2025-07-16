output "network_name" {
  value = google_compute_network.main.name
}

output "subnet_name" {
  value = google_compute_subnetwork.main.name
}

output "private_ip_range_name" {
  value = google_compute_global_address.private_ip_range.name
} 