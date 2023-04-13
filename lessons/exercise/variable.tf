variable "project-id" { default = "lively-shelter-294615"}
variable "vm_machine_type" {
  type = map(string)
  default = {
    "dev"  = "e2-standard-2"
    "prod" = "e2-standard-4"
  }
}
variable "environment" { default = "production" }
variable "vm_os_image" { default = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230214" }
