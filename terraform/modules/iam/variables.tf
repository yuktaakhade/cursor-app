variable "account_id" {
  type        = string
  description = "Service account ID"
}
variable "display_name" {
  type        = string
  description = "Service account display name"
}
variable "roles" {
  type        = list(string)
  description = "Roles to assign"
}
variable "project_id" {
  type        = string
  description = "GCP project ID"
} 