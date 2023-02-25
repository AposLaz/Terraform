####################################################################################
# PROVIDER variables
variable "project_name" {
  default = "lively-shelter-294615"
}

variable "region_name" {
  default = "europe-west8-a"
}

#################################################################################### 
# VM1 configuration variables                    
 
variable "vm1_name" {
  default = "test-terraform"
}

variable "vm1_machine_type" {
  default = "e2-standard-2"
}

variable "vm1_zone" {
  default = "europe-west8-a"
}

variable "vm1_os_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230214"
}

####################################################################################
