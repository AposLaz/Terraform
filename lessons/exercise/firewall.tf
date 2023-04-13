resource "google_compute_firewall" "allow_port_ssh" {
  name = "allow-ssh-port"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  target_tags = [ "allow-ssh-port" ]
  source_ranges = ["0.0.0.0/0"]
}

