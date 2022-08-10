resource "yandex_compute_instance" "elastic-bastion" {
  count = var.create_elastic_bastion == true ? 1 : 0

  name        = "develz-elastic-bastion"
  hostname    = "elastic-bastion"
  description = "Bastion for ElasticSearch cluster"
  platform_id = "standard-v1"
  labels = {
    group = "devops",
    app   = "elasticsearch"
  }

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 20
  }

  boot_disk {
    mode = ""
    initialize_params {
      image_id = "fd8ovo09vrcggmpqjm4v"
      type     = "network-hdd"
      size     = 10
    }
  }

  network_interface {
    subnet_id  = var.subnet_id
    ip_address = var.bastion_internal_ip
    ipv6       = false
    nat        = true
  }

  metadata = {
    group     = "devops"
    user-data = file("./files/user-data.yml")
  }
}
