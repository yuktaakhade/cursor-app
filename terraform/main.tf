module "vpc" {
  source     = "./modules/vpc"
  project_id = var.project_id
  region     = var.region
}

module "sql" {
  source        = "./modules/sql"
  project_id    = var.project_id
  region        = var.region
  db_user       = var.db_user
  db_password   = var.db_password
  vpc_network   = module.vpc.network_name
}

module "artifact_registry" {
  source     = "./modules/artifact_registry"
  project_id = var.project_id
  region     = var.region
  repo_name  = var.artifact_repo_name
}

module "workload_identity" {
  source      = "./modules/workload_identity"
  project_id  = var.project_id
  github_org  = var.github_org
  github_repo = var.github_repo
  workload_identity_pool_id = var.workload_identity_pool_id
}

module "service_account" {
  source                 = "./modules/service_account"
  project_id             = var.project_id
  workload_identity_pool = module.workload_identity.eshop_github_pool_id
  github_org             = var.github_org
  github_repo            = var.github_repo
} 