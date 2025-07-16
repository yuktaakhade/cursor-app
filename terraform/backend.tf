terraform {
  backend "gcs" {
    bucket  = "eshop-tf-state-yukta2"
    prefix  = "eshop/terraform/state"
  }
} 