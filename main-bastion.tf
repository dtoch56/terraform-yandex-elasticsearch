locals {
  elasticsearch_hosts = [for h in yandex_mdb_elasticsearch_cluster.elastic.host : h.fqdn]

  bastion_security_group_ids = var.bastion_default_security_groups == true ? setunion([
    yandex_vpc_security_group.elastic-bastion[0].id
  ], var.bastion_security_group_ids) : var.bastion_security_group_ids
}

resource "yandex_vpc_security_group" "elastic-bastion" {
  count = var.create_elastic_bastion ? 1 : 0

  name        = "${var.bastion_name}-default"
  description = "Default security group for Elasticsearch bastion"
  folder_id   = var.folder_id
  network_id  = var.network_id

  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = length(var.vpn_ips) == 0 ? ["0.0.0.0/0"] : var.vpn_ips
  }
  egress {
    protocol       = "ANY"
    description    = "For outgoing traffic that allows Elasticsearch bastion to connect to external resources"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}

resource "yandex_compute_instance" "elastic-bastion" {
  count = var.create_elastic_bastion ? 1 : 0

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
    subnet_id          = var.host_subnet_id
    ip_address         = var.bastion_internal_ip
    ipv6               = false
    nat                = true
    security_group_ids = local.bastion_security_group_ids
  }

  metadata = {
    group     = "devops"
    user-data = file(var.bastion_cloud_init_user_data_file)
  }

  provisioner "remote-exec" {
    inline = ["hostname"]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ansbl"
      private_key = file(var.bastion_ssh_key_private_file)
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
ansible-playbook \
-u ansbl \
-i '${self.network_interface[0].nat_ip_address}' \
--private-key ${var.bastion_ssh_key_private_file} \
-e "ansible_become_pass=${var.ansible_become_pass}" \
-e "es_api_host=${local.elasticsearch_hosts[0]}" \
-e "es_api_basic_auth_password=${yandex_mdb_elasticsearch_cluster.elastic.config[0].admin_password}" \
-e "jaeger_admin_password=${var.jaeger_admin_password}" \
-e "fluentd_admin_password=${var.fluentd_admin_password}" \
${path.module}/ansible/main.yml
EOT
  }
}

output "bastion_public_ip" {
  description = "Elasticsearch bastion public IP address"
  value       = var.create_elastic_bastion ? yandex_compute_instance.elastic-bastion[0].network_interface[0].nat_ip_address : null
}

output "bastion_fqdn" {
  description = "Elasticsearch bastion FQDN"
  value       = var.create_elastic_bastion ? yandex_compute_instance.elastic-bastion[0].fqdn : null
}

