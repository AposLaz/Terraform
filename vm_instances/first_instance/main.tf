#create 3 VMs
resource "google_compute_instance" "default" {
  count = "${length(var.name_count)}"
  name         = "${var.vm_name}-${count.index+1}"
  machine_type = "${var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]}"
  zone         = var.vm_zone

  boot_disk {
    initialize_params {
      image = var.vm_os_image
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}