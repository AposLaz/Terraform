resource "null_resource" "jaeger" {
  provisioner "local-exec" {
    command = "kubectl apply -f ${var.configuration_path}/jaeger/jaeger.yaml"
  }

  depends_on = [
    helm_release.jaeger_operator
  ]
}
