# main.tf
resource "google_iam_workload_identity_pool" "github_pool" {
  provider                  = google
  workload_identity_pool_id = var.workload_identity_pool_id
  display_name              = "eshop GitHub Actions Pool"
  description               = "OIDC pool for GitHub Actions for eshop"
}

resource "google_iam_workload_identity_pool_provider" "github_provider" {
  provider                           = google
  workload_identity_pool_id          = google_iam_workload_identity_pool.github_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "eshop-github-provider"
  display_name                       = "eshop GitHub Actions Provider"
  description                        = "OIDC provider for GitHub Actions for eshop"
  attribute_mapping = {
    "google.subject"      = "assertion.sub"
    "attribute.actor"     = "assertion.actor"
    "attribute.repository"= "assertion.repository"
    "attribute.ref"       = "assertion.ref"
  }
  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }
}

output "eshop_github_pool_id" {
  value = google_iam_workload_identity_pool.github_pool.name
}
output "eshop_github_provider_name" {
  value = google_iam_workload_identity_pool_provider.github_provider.name
} 