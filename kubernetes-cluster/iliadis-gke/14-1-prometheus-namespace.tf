/** Intsall Prometheus Nmaespace **/

resource "null_resource" "prometheus-namespace" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.application_path}/prometheus/prometheus-namespace.yaml"
  }

  depends_on = [
    helm_release.gateway
  ]
}




