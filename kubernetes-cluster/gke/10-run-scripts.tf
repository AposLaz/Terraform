resource "null_resource" "connecto_gcloud" {
    provisioner "local-exec" {
      command = "gcloud"
    }
}

resource "null_resource" "install_ingress_nginx" {
  
  provisioner "local-exec" {
    command = "helm install ingress-nginx ingress-nginx/ingress-nginx"
  }

  depends_on = [ 
    null_resource.connecto_gcloud
   ]
}