variable "path" {
  default = "/home/apostolos/Desktop/terraform/credentials"
}

provider "google" {
  project     = var.project_name
  region      = var.region_name
  credentials = file("${var.path}/secrets.json")
}