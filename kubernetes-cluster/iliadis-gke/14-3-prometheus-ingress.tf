resource "helm_release" "ingress-nginx" {
  name             = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  values = [
    "${file("${var.helm-charts}/ingress-values.yaml")}"
  ]

  wait    = true
  timeout = 3000

  depends_on = [
    helm_release.prometheus-helm
  ]
}


