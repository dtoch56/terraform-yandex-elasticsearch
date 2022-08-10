locals {
  security_group_ids = var.default_security_groups == true ? setunion([
          yandex_vpc_security_group.public-services[0].id
      ], var.security_group_ids) : var.security_group_ids
}

resource "yandex_mdb_elasticsearch_cluster" "elastic" {
  name        = var.name
  description = var.description
  environment = var.environment
  network_id  = var.network_id
  folder_id   = var.folder_id
  security_group_ids = local.security_group_ids
  service_account_id  = yandex_iam_service_account.es.id
  deletion_protection = false

  config {
    version = var.elastic_version
    edition = var.elastic_edition
#    plugins        =
    admin_password = var.admin_password

    data_node {
      resources {
        resource_preset_id = "s2.micro"
        disk_type_id       = "network-ssd"
        disk_size          = 20
      }
    }

#    master_node {
#    }
  }

  host {
    name             = "develz-elastic-node"
    zone             = var.zone
    type             = "DATA_NODE"
    assign_public_ip = false
    subnet_id        = var.subnet_id
  }
}


