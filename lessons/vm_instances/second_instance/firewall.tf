# SET FIREWALL RULES

resource "google_compute_firewall" "allow_http" {
  name = "allow-http-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["80"]
  }

  target_tags = [ "allow-http" ]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_https" {
  name = "allow-https-terraform"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["443"]
  }

  target_tags = [ "allow-https" ]
  source_ranges = ["0.0.0.0/0"]
}