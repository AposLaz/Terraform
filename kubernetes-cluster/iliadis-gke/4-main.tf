data "google_client_config" "main" {}

#Enable compute API
#To create a GKE cluster, you also need to enable container google API

#compute engine API
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
  disable_dependent_services = true
}

#kubernetes API
resource "google_project_service" "container" {
  service = "container.googleapis.com"
  disable_dependent_services = true
}