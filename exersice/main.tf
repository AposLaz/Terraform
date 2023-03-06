resource "google_compute_instance" "vm_instance" {
    name = "vm-instance-ex"
    machine_type = var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]
    
    disk {
        variable "vm_os_image" { default = "ubuntu-os-cloud/ubuntu-2204-jammy-v20230214" }
    }
}