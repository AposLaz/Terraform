resource "null_resource" "kube-prometheus" {
  provisioner "local-exec" {
    command = "helm upgrade --install kube-prometheus-stack --repo https://prometheus-community.github.io/helm-charts kube-prometheus-stack --namespace ${var.istio_namespace} --create-namespace --values ${var.helm-charts}/values-kube-prometheus.yml"
  }
}