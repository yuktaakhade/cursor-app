# GitHub Actions CI/CD Workflow Documentation

## Overview
This repository uses GitHub Actions for a secure, automated CI/CD pipeline to deploy a Python application to Google Kubernetes Engine (GKE) on Google Cloud Platform (GCP), with all infrastructure provisioned by Terraform.

## Workflow Sequence
Workflows are designed to run sequentially, ensuring infrastructure is provisioned before testing and deployment. Each workflow is focused and avoids redundant steps.

### 1. Provision GCP Infrastructure
- **Workflow:** `terraform-infra.yml`
- **Trigger:** On push to `main` or manual dispatch
- **Purpose:** Provisions all required GCP resources (including GKE cluster, Artifact Registry, etc.) using Terraform.
- **Authentication:** Uses Workload Identity Federation (no service account keys)
- **Best Practices:**
  - Only necessary resources are created.
  - Use `terraform destroy` for unused resources to save costs.
  - Review the Terraform plan before applying changes.

### 2. Test and Deploy to GKE
- **Workflow:** `gke-cicd.yaml`
- **Trigger:** Runs automatically after infrastructure provisioning completes.
- **Purpose:**
  - Checks out the code
  - Sets up Python and installs dependencies
  - Runs unit tests and code coverage
  - Authenticates to GCP (Workload Identity Federation)
  - Waits for the GKE cluster to be ready
  - Deploys the application to GKE using a rolling update (only if all tests pass)
- **Best Practices:**
  - Only tested code is deployed
  - Uses rolling updates for zero-downtime deployments
  - Ensures resource requests/limits and HPA are set in Kubernetes manifests to avoid over-provisioning

## Cost-Effectiveness
- Workflows are focused and do not repeat steps, minimizing CI minutes and cloud resource usage.
- HPA and resource limits in Kubernetes help control GKE costs.
- Unused resources should be destroyed via Terraform to avoid unnecessary charges.

## Security
- Uses Workload Identity Federation for authentication (no static service account keys)
- All secrets are managed via GitHub repository secrets

## Maintenance Tips
- Update secrets in GitHub repository settings as needed.
- Review and update Terraform and Kubernetes manifests for new features or optimizations.
- Monitor workflow runs in the GitHub Actions tab for failures or bottlenecks.

## Extending the Pipeline
- Add more test steps (e.g., integration tests) before deployment if needed.
- Add notification steps (e.g., Slack, email) for deployment status.
- Use additional environments (staging, production) by extending the workflow logic.

---

For questions or improvements, please contact the repository maintainer. 