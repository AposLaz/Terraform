resource "null_resource" "connecto_gcloud" {
    provisioner "local-exec" {
      command = "gcloud container clusters get-credentials primary --region europe-west8 --project lively-shelter-294615"
    }

    depends_on = [ 
        google_container_cluster.primary
     ]
}

resource "null_resource" "install_ingress_nginx" {
  
  provisioner "local-exec" {
    command = "helm install ingress-nginx ingress-nginx/ingress-nginx"
  }

  depends_on = [ 
    null_resource.connecto_gcloud
   ]
}