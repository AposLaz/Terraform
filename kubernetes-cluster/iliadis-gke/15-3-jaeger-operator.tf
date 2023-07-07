# /**
#     Install Jaeger
# */

resource "helm_release" "jaeger_operator" {
  name             = "jaeger-operator"
  repository       = "https://jaegertracing.github.io/helm-charts"
  chart            = "jaeger-operator"
  namespace        = "observability"
  create_namespace = true
  timeout          = 3600
  # Ensure jaeger-operator operates on things (e.g. CRs) in cluster-wide scope.
  set {
    name  = "rbac.clusterRole"
    value = true
  }

  depends_on = [
    null_resource.cert-manager-install
  ]
}
