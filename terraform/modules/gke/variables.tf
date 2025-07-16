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