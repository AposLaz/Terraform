#create 3 VMs
resource "google_compute_instance" "default" {
  count        = length(var.machine_count) #How many vms I want to create
  name         = "${var.vm_name}-${count.index + 1}"
  machine_type = var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]
  zone         = var.vm_zone

  can_ip_forward = "false"                                       #forward IP must be false in most cases
  description    = "Create Virtual Machines with firewall rules" #description for my VMs

  tags = ["allow-http","allow-https"] # FIREWALL

  # Initialize OS and DISK SPACE
  boot_disk {
    initialize_params {
      image = var.vm_os_image
      size  = var.vm_size_GB
    }
  }

  # Labels that describe our Machine
  labels = {
    name         = "${var.vm_name}-${count.index + 1}"
    machine_type = "${var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]}"
  }

  metadata = {
    size = "20"
    foo  = "bar"
  }

  metadata_startup_script = "echo hi > test.txt"

  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}