resource "google_project_iam_member" "gke_sa_roles" {
  for_each = toset(var.roles)
  project  = var.project_id
  role     = each.key
  member   = "serviceAccount:${var.account_id}"
}

output "service_account_email" {
  value = var.account_id
} 