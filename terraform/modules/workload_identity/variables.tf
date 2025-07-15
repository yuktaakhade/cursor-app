variable "project_id" {}
variable "github_org" {}
variable "github_repo" {}
variable "workload_identity_pool_id" {
  description = "Name for the Workload Identity Pool"
  default     = "eshop-github-pool"
} 