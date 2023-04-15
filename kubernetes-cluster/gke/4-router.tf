/*
    Next, we need to create Cloud Router to advertise routes. It will be used with the NAT gateway 
    to allow VMs without public IP addresses to access the internet. For example, Kubernetes nodes 
    will be able to pull docker images from the docker hub.
*/

resource "google_compute_router" "k8s-router" {
    name = "k8s-router"
    region = var.region
    network = google_compute_network.k8s-main.id #cloud router is connected with this network
}