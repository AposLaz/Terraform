resource "helm_release" "my-kafka" {
  name       = "my-kafka"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "kafka"

  values = [
    file("${var.helm-charts}/kafka-values.yaml")
  ]
}



# resource "helm_release" "nginx_ingress_controller" {
#   name  = "ingress-nginx"
#   repository = "https://kubernetes.github.io/ingress-nginx"
#   chart = "ingress-nginx"
#   namespace = "kube-system"
#   create_namespace = true

#   wait = true
#   timeout = 3000
# }


