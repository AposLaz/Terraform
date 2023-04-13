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
  project     = var.project-id
  region      = "europe-west8-a"
  credentials = file("${var.path}/secrets.json")
}
