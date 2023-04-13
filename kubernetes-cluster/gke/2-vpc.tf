#Before creating VPC in a new GCP project
#Enable compute API
#To create a GKE cluster, you also need to enable container google API

#compute engine API
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

#kubernetes API
resource "google_project_service" "container" {
  service = "container.googleapis.com"
}

#Create VPC network
resource "google_compute_network" "k8s-main" {
    name = var.vpc-name
    auto_create_subnetworks = false
    routing_mode = "REGIONAL"
    mtu = 1460 # Maximum Transmission Unit in bytes
    delete_default_routes_on_create = false

    depends_on = [
      google_project_service.compute,
      google_project_service.container
    ]
}