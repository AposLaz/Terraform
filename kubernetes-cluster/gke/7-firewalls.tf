resource "google_compute_firewall" "allow-ssh" {
  name = "allow-ssh"
  network = google_compute_network.k8s-main.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-http" {
  name = "allow-http"
  network = google_compute_network.k8s-main.name

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-https" {
  name = "allow-https"
  network = google_compute_network.k8s-main.name

  allow {
    protocol = "tcp"
    ports = ["443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow-ingress-nginx" {
  name = "allow-ingress-nginx"

  network = google_compute_network.k8s-main.name

  allow {
    protocol = "tcp"
    ports = ["8443"]
  }

  source_ranges = ["0.0.0.0/0"]
}