resource "helm_release" "my-kafka" {
  name       = "my-kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"

  values = [
    file("${var.helm-charts}/kafka-values.yaml")
  ]
}



resource "google_compute_address" "ingress_ip_address" {
  name = "nginx-controller"
}

module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"

  ip_address = google_compute_address.ingress_ip_address.address
  additional_set = []
}


