/**
    Cert manager is a Prerequisite for run jaeger trace

    Since version 1.31 the Jaeger Operator uses webhooks to validate Jaeger custom resources (CRs). 
    This requires an installed version of the cert-manager.

    Read More: https://faun.pub/how-to-deploy-jaeger-on-kubernetes-69cf48447182

    kubectl get pods -n cert-manager (By default cert-manager install in default namespace)
*/

resource "null_resource" "cert-manager-install" {
  provisioner "local-exec" {
    command = "kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.9.0/cert-manager.yaml"
  }

  depends_on = [helm_release.kiali-install]
}
