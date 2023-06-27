resource "helm_release" "prometheus-helm" {
  name       = "prometheus"
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "prometheus-community"
  namespace  = "monitoring"


  depends_on = [null_resource.prometheus-namespace]
}
