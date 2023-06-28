resource "null_resource" "istio-scrape" {
  provisioner "local-exec" {
    command = "kubectl create -f ${var.configuration_path}/istio/istio-scrape.yaml"
  }

  depends_on = [
    helm_release.ingress-nginx
  ]

}
