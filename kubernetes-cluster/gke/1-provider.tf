########################## PROVIDER ###############################

# Define a backend for store the state

terraform {
  backend "gcs" {
    bucket = "state-tf-bucket"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project = var.project-id
  region = var.region
  credentials = file("${var.credentials_gcp}/secrets.json")
}