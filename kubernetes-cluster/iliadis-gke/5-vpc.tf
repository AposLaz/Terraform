#Before creating VPC in a new GCP project

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



