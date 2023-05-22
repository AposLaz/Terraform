resource "google_container_cluster" "primary" {
  name = "primary"
  location = var.region
  remove_default_node_pool = true
  initial_node_count = 1
  /**
    Define how applications in this cluster communicate with each other and with 
    the Kubernetes control plane, and how clients can reach them.
  */
  network = google_compute_network.k8s-main.self_link
  subnetwork = google_compute_subnetwork.private.self_link


  logging_service = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"
  networking_mode = "VPC_NATIVE"
  
  /* If we want NODE run in specific zones then specify them */
  /**
    node_locations = [ 
        "europe-west8-a",
        "europe-west8-b",
        "europe-west8-c"
    ]
  */

  addons_config {
    http_load_balancing {
      disabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }
  }

  release_channel {
    channel = "REGULAR"
  }

  workload_identity_config {
    workload_pool = "${var.project-id}.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = "k8s-pod-range"
    services_secondary_range_name = "k8s-svc-range"
  }

  private_cluster_config {
    enable_private_nodes = true
    enable_private_endpoint = false
    master_ipv4_cidr_block = "172.16.0.0/28"
  }
}