/*
                          Cloud NAT
                          
    Give it a name and a reference to the Cloud Router. 
    Then the region europe-west8-a. You can decide to advertise 
    this Cloud NAT to all subnets in that VPC, or you can select 
    specific ones. In this example, I will choose the private subnet only.
*/

resource "google_compute_router_nat" "k8s-nat" {
  name = "k8s-nat"
  router = google_compute_router.k8s-router.name    #connect to the router
  region = var.region

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"    #only subnets allowed to NAT
  nat_ip_allocate_option = "MANUAL_ONLY"    #for only user-allocated NAT IP addresses

  subnetwork {
    name = google_compute_subnetwork.private.id
    source_ip_ranges_to_nat = [ "ALL_IP_RANGES" ]     # List of options for which source IPs in the subnetwork should have NAT enabled
  }
  #A list of URLs of the IP resources used for this Nat service. 
  #These IP addresses must be valid static external IP addresses assigned to the project.
  nat_ips = [google_compute_address.k8s-nat-address.self_link]  
}


resource "google_compute_address" "k8s-nat-address" {
  name = "k8s-nat-address"
  address_type = "EXTERNAL"

  #Internal IP addresses are always Premium Tier.
  #Global external IP addresses are always Premium Tier. 
  #Regional external IP addresses can be either Standard or Premium Tier. 
  network_tier = "PREMIUM"  

  depends_on = [
    google_project_service.compute
  ]
}