# # Apply YAML kubernetes-manifest configurations
# resource "null_resource" "apply_google_eshop" {
#   provisioner "local-exec" {
#     # interpreter = ["bash", "-exc"]
#     command     = "kubectl apply -f ${var.google_eshop_path} -n ${var.namespace}"
#   }

#   depends_on = [ 
#     null_resource.connecto_gcloud
#    ]

# }

# # Wait condition for all Pods to be ready before finishing
# resource "null_resource" "wait_conditions_google" {
#   provisioner "local-exec" {
#     interpreter = ["bash", "-exc"]
#     command     = "kubectl wait --for=condition=ready pods --all -n ${var.namespace} --timeout=-1s 2> /dev/null"
#   }

#   depends_on = [
#     resource.null_resource.apply_google_eshop
#   ]
# }
