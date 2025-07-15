resource "google_service_account" "github_sa" {
  account_id   = "github-actions-sa"
  display_name = "GitHub Actions Service Account"
}

resource "google_service_account_iam_member" "workload_identity_binding" {
  service_account_id = google_service_account.github_sa.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = "principalSet://iam.googleapis.com/${var.workload_identity_pool}/attribute.repository/${var.github_org}/${var.github_repo}"
}

output "email" {
  value = google_service_account.github_sa.email
} 