/*
    Create a private subnet to place Kubernetes nodes.
*/

resource "google_compute_subnetwork" "private" {
  name = "private"
  #The IP address range that machines in this network are assigned to, represented as a CIDR block.
  ip_cidr_range = "10.0.0.0/18"  
  region = var.region
  #connect to network
  network = google_compute_network.k8s-main.id
  #Whether the VMs in this subnet can access Google services without assigned external IP addresses for example Redis, PostgreSQL etc...
  private_ip_google_access = true 

  secondary_ip_range {
    range_name = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/14"
  }

  secondary_ip_range {
    range_name = "k8s-svc-range"
    ip_cidr_range = "10.52.0.0/20" #when create a svc in K8s it will take ip from this range
  }
}



