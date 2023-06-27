# INGRESS 
data "kubectl_filename_list" "manifests_ingress" {
  pattern = "./configuration/prometheus/ingress-prometheus.yaml"
}

resource "kubectl_manifest" "ingress-manifest" {
  count     = length(data.kubectl_filename_list.manifests_ingress.matches)
  yaml_body = file(element(data.kubectl_filename_list.manifests_ingress.matches, count.index))

  depends_on = [
    helm_release.kiali-install
  ]
}
