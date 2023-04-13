resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = google_compute_network.k8s-main.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}