output "cloud_sql_instance_connection_name" {
  value     = module.sql.connection_name
  sensitive = true
}
output "artifact_registry_repo" {
  value = module.artifact_registry.repo_id
}
output "workload_identity_provider" {
  value = module.workload_identity.eshop_github_provider_name
}
output "service_account_email" {
  value = module.service_account.email
  sensitive = true
} 