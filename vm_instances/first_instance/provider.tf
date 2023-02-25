terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

variable "path" {
  default = "/home/apostolos/Desktop/terraform/vm_instances/credentials"
}

provider "google" {
  project     = var.project_name
  region      = var.region_name
  credentials = file("${var.path}/secrets.json")
}