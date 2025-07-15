terraform {
  backend "gcs" {
    bucket  = "<your-tf-state-bucket>"
    prefix  = "eshop/terraform/state"
  }
} 