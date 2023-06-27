resource "helm_release" "prometheus-helm" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  namespace  = "istio-system"

  values = [
    "${file("${var.helm-charts}/prometheus-values.yaml")}"
  ]

  wait    = true
  timeout = 3000

  depends_on = [null_resource.prometheus-namespace]
}
