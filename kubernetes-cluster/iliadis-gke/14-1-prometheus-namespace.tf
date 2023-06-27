/** Intsall Prometheus Nmaespace **/

resource "null_resource" "prometheus-namespace" {
  provisioner "local-exec" {
    command = "kubectl apply -f /home/apostolos/Desktop/Terraform/kubernetes-cluster/iliadis-gke/configuration/prometheus/prometheus-namespace.yaml"
  }

  depends_on = [
    helm_release.gateway
  ]
}




