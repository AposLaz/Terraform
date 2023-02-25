resource "google_compute_instance" "default" {
  name         = var.vm1_name
  machine_type = var.vm1_machine_type
  zone         = var.vm1_zone

  boot_disk {
    initialize_params {
      image = var.vm1_os_image
    }
  }

  network_interface {
    network = "default"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }
}