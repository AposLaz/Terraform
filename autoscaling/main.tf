#Instance Template <- Describe Instance

resource "google_compute_instance_template" "instance_template" {
  count = 1
  name = "udemy-server-${count.index+1}"
  description = "This is our autoscaling template"
  #tags = [] #network

  labels = {
    environment = "production"
    name = "udemy-server-${count.index+1}"
  }

  instance_description = "This is an instance that has been auto scaled"
  machine_type = "e2-standard-2"
  can_ip_forward = "false"

  scheduling {
    automatic_restart = "true" #if something happens to instance it will be going to restart itself
    on_host_maintenance = "MIGRATE" #optional
  }

  network_interface {
    network = "default"
  }

  disk {
    source_image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230214"
    auto_delete = "true" #If instance deleted you want the disk deleted
    boot = "true"
  }

  disk {
    auto_delete = "false"
    disk_size_gb = 10
    mode = "READ_WRITE"
    type = "PERSISTENT"
  }

  metadata = {
    foo = "bar"
  }

  service_account {
    scopes = ["userinfo-email","compute-ro","storage-ro"]
  }
}

# Heath Check <-- Auto Scaling Policy (When to Scale)

resource "google_compute_health_check" "health"{
  count = 1
  name = "udemy"
  check_interval_sec = 5  #how many times it is going to check? (every 5 seconds)
  timeout_sec = 5 #if we check every 5seconds and do not get back a response what is going to be?
  healthy_threshold = 2
  unhealthy_threshold = 10

  http_health_check {
    request_path = "/alive.jsp"
    port = "8080"
  }
}

# Group Manager <-- Manages the nodes

resource "google_compute_region_instance_group_manager" "instance_group_manager" {
  name = "instance-group-manager"

  version {
    instance_template = "${google_compute_instance_template.instance_template[0].self_link}"   # next is the instance template so you've got to point it to the template so it knows where to look
  }

  base_instance_name = "instance-group-manager"
  region = "europe-west8"

  #healthcheck and where going to point
  # auto_healing_policies {
  #   health_check = "${google_compute_health_check.health.self_link}"
  #   initial_delay_sec = 300 
  #   #The number of seconds that the managed instance group waits before it applies autohealing 
  #   #policies to new instances or recently recreated instances. Between 0 and 3600.
  # }
}

# Auto Scale Policy <--How many instances

resource "google_compute_region_autoscaler" "autoscaler" {
  count = 1
  name = "autoscaler"
  project = "lively-shelter-294615"
  region = "europe-west8"
  target = "${google_compute_region_instance_group_manager.instance_group_manager.self_link}" #what are you looking for group manager

  autoscaling_policy {
    max_replicas = 2
    min_replicas = 1
    cooldown_period = 60
    cpu_utilization {
      target = "0.8"
    }
  }
}