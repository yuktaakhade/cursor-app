output "network_name" {
  value = google_compute_network.vpc_network.id
}

output "private_ip_range_name" {
  value = google_compute_global_address.private_ip_range.name
} 