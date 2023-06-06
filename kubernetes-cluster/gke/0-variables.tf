################################### PROVIDER ##############################
variable "credentials_gcp" { default = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/credentials" }
variable "project-id" { default = "lively-shelter-294615"}
variable "region" { default = "europe-west8"}

#VPC k8s-main
variable "vpc-name" { default = "k8s-main" }

#Helm
variable "helm-charts" { default = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/gke/helm-charts" }

#Namespaces
variable "namespace" {
  type        = string
  description = "Kubernetes Namespace in which my application resources are to be deployed"
  default     = "default"
}

variable "istio_namespace" {
  type = string
  description = "Kubernetes for istio & monitoring namespace"
  default = "istio-stystem"
}

#Namespaces
variable "google_eshop_path" {
  type        = string
  description = "Google Eshop"
  default     = "./applications/google-eshop/kubernetes-manifests.yaml"
}
