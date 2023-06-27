resource "helm_release" "kiali-install" {
  name       = "kiali-server"
  repository = "https://kiali.org/helm-charts"
  chart      = "kiali-server"
  namespace  = "istio-system"
  values = [
    "${file("${var.helm-charts}/kiali-values.yaml")}"
  ]

  depends_on = [
    null_resource.istio-scrape
  ]
}
