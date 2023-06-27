resource "null_resource" "istio-scrape" {
  provisioner "local-exec" {
    command = "kubectl create -f /home/apostolos/Desktop/Terraform/kubernetes-cluster/iliadis-gke/configuration/istio/istio-scrape.yaml"
  }

  depends_on = [
    helm_release.ingress-nginx
  ]

}
