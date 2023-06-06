resource "null_resource" "connecto_gcloud" {
    provisioner "local-exec" {
      command = "gcloud container clusters get-credentials primary --region ${var.region} --project ${var.project-id}"
    }

    depends_on = [ 
        google_container_cluster.primary
     ]
}

resource "null_resource" "install_ingress_nginx" {
  
  provisioner "local-exec" {
    command = "helm install ingress-nginx ingress-nginx/ingress-nginx --values ${var.helm-charts}/ingress-values.yaml"
  }

  depends_on = [ 
    null_resource.connecto_gcloud
   ]
}