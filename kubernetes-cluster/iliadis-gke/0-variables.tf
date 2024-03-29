################################### PROVIDER ##############################
variable "credentials_gcp" {
  type        = string
  description = "My project credentials"
}

variable "project-id" {
  type        = string
  description = "My project Id"
}

variable "region" {
  type        = string
  description = "Region for GKE cluster"
}

variable "zone" {
  type        = string
  description = "Zone for GKE cluster"
}


#VPC k8s-main
variable "vpc-name" {
  type        = string
  description = "VPC network for GKE"
}

#Helm
variable "helm-charts" {
  type        = string
  description = "path for helm charts"
  default     = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/iliadis-gke/helm-charts"
}

#Namespaces
variable "namespace" {
  type        = string
  description = "Kubernetes Namespace in which my application resources are to be deployed"
  default     = "default"
}

variable "istio_namespace" {
  type        = string
  description = "Kubernetes for istio & monitoring namespace"
  default     = "istio-system"
}

variable "application_path" {
  type        = string
  description = "Path from application folders"
  default     = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/iliadis-gke/applications"
}

variable "configuration_path" {
  type        = string
  description = "Path from application folders"
  default     = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/iliadis-gke/configuration"
}

variable "google_eshop_ns" {
  type        = string
  description = "Kubernetes Namespace for google eshop"
}


