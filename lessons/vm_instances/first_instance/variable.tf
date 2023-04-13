####################################################################################
# PROVIDER variables
variable "project_name" {
  default = "lively-shelter-294615"
}

variable "region_name" {
  default = "europe-west8-a"
}

#################################################################################### 
# VM configuration variables                    
 
# I will create 3 vms
variable "name_count" {
  default = ["server1","server2","server3"]
}

variable "vm_name" {
  default = "test-terraform"
}

variable "environment" {
  default = "production"
}

 variable "vm_machine_type" {
  type = map(string)          
  default = {
    "dev" = "e2-standard-2"
    "prod" = "e2-standard-4"
  }
}


variable "vm_zone" {
  default = "europe-west8-a"
}

variable "vm_os_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230214"
}

####################################################################################
