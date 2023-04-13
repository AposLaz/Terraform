resource "google_compute_instance" "vm_instance" {
    name = "vm-instance-ex"
    machine_type = var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]
    zone = "europe-west8-a"
    can_ip_forward = "false"                                       #forward IP must be false in most cases
    description    = "Create Virtual Machines with firewall rules" #description for my VMs
    tags = ["allow-ssh-port"] #FIREWALL

    # Labels that describe our Machine
    labels = {
        name         = "vm-instance-ex"
        machine_type = "${var.environment == "production" ? var.vm_machine_type["prod"] : var.vm_machine_type["dev"]}"
    }

    boot_disk {
        initialize_params{
            image = var.vm_os_image
            size = 10
        }
    }

    network_interface {
        network = "default"
    }

    service_account {
        scopes = ["userinfo-email", "compute-ro", "storage-ro"]
    }

}