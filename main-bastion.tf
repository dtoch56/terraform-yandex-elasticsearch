resource "yandex_compute_instance" "elastic-bastion" {
  count = var.create_elastic_bastion == true ? 1 : 0

  folder_id   = var.folder_id
  zone        = var.host_zone
  name        = var.bastion_name
  hostname    = var.bastion_hostname
  description = var.bastion_description
  platform_id = var.bastion_platform_id
  labels      = var.bastion_labels

  resources {
    cores         = var.bastion_cores
    memory        = var.bastion_memory
    core_fraction = var.bastion_core_fraction
  }

  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = var.bastion_image_id
      type     = var.bastion_disk_type
      size     = var.bastion_disk_size
    }
  }

  network_interface {
    subnet_id  = var.host_subnet_id
    ip_address = var.bastion_internal_ip
    ipv6       = false
    nat        = true
  }

  metadata = {
    group     = "devops"
    user-data = file("./files/user-data.yml")
  }
}
