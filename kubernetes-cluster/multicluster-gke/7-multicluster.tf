

# resource "google_gke_hub_membership" "membership" {
#   count         = length(var.cluster-zones)
#   membership_id = "cluster-${count.index}"
#   endpoint {
#     gke_cluster {
#       resource_link = google_container_cluster.primary[count.index].id
#     }
#   }
#   depends_on = [
#     google_container_node_pool.general
#   ]
# }

# # Grant the required Identity and Access Management (IAM) permissions for MCS Importer:
# resource "null_resource" "grant_permissions" {
#   provisioner "local-exec" {
#     command = "gcloud projects add-iam-policy-binding ${var.project-id} --member 'serviceAccount:${var.project-id}.svc.id.goog[gke-mcs/gke-mcs-importer]' --role 'roles/compute.networkViewer'"
#   }

#   depends_on = [google_gke_hub_membership.membership]
# }
