variable "name" {
  type        = string
  description = "GKE cluster name"
}
variable "location" {
  type        = string
  description = "GKE location"
}
variable "network_id" {
  type        = string
  description = "VPC network ID"
}
variable "subnet_id" {
  type        = string
  description = "Subnet ID"
}
variable "project_id" {
  type        = string
  description = "GCP project ID"
} 