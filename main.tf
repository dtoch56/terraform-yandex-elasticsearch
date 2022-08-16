locals {
  security_group_ids = var.default_security_groups == true ? setunion([
    yandex_vpc_security_group.public-services[0].id
  ], var.security_group_ids) : var.security_group_ids
}

resource "yandex_mdb_elasticsearch_cluster" "elastic" {
  name                = var.name
  description         = var.description
  environment         = var.environment
  network_id          = var.network_id
  folder_id           = var.folder_id
  security_group_ids  = local.security_group_ids
  service_account_id  = local.service_account_id
  deletion_protection = var.deletion_protection
  labels              = var.labels

  config {
    version        = var.elastic_version
    edition        = var.elastic_edition
    plugins        = var.plugins
    admin_password = var.admin_password

    data_node {
      resources {
        resource_preset_id = var.data_node_resource_preset_id
        disk_type_id       = var.data_node_disk_type_id
        disk_size          = var.data_node_disk_size
      }
    }

    master_node {
      resources {
        resource_preset_id = var.data_node_resource_preset_id
        disk_type_id       = var.data_node_disk_type_id
        disk_size          = var.data_node_disk_size
      }
    }
  }

  host {
    name             = var.host_name
    zone             = var.host_zone
    type             = var.host_type
    subnet_id        = var.host_subnet_id
    assign_public_ip = var.host_assign_public_ip
  }

  maintenance_window {
    type = var.maintenance_type
    day  = var.maintenance_day
    hour = var.maintenance_hour
  }
}


