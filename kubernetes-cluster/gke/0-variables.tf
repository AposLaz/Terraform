################################### PROVIDER ##############################
variable "credentials_gcp" { default = "/home/apostolos/Desktop/Terraform/kubernetes-cluster/credentials" }
variable "project-id" { default = "lively-shelter-294615"}
variable "region" { default = "europe-west8"}

#VPC k8s-main
variable "vpc-name" { default = "k8s-main" }