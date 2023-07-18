# Retrieve an access token as the Terraform runner
data "google_client_config" "main" {}

#Enable compute API
#To create a GKE cluster, you also need to enable container google API

#compute engine API
resource "google_project_service" "compute" {
  service                    = "compute.googleapis.com"
  disable_dependent_services = true
}

#kubernetes API
resource "google_project_service" "container" {
  service                    = "container.googleapis.com"
  disable_dependent_services = true
}

#MULTICLUSTER DISCOVERY API
resource "google_project_service" "multi-cluster-discovery" {
  service                    = "multiclusterservicediscovery.googleapis.com"
  disable_dependent_services = true
}
#GKE HUB API
resource "google_project_service" "gke-hub" {
  service                    = "gkehub.googleapis.com"
  disable_dependent_services = true
}

#CLOUD RESOURCE MANAGER
resource "google_project_service" "cloud-resource-manager" {
  service                    = "cloudresourcemanager.googleapis.com"
  disable_dependent_services = true
}
#TRAFFIC DIRECTOR API
resource "google_project_service" "traffic-director" {
  service                    = "trafficdirector.googleapis.com"
  disable_dependent_services = true
}

#CLOUD DNS API
resource "google_project_service" "cloud-dns" {
  service                    = "dns.googleapis.com"
  disable_dependent_services = true
}


