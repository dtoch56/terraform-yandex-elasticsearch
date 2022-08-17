resource "yandex_vpc_security_group" "public-services" {
  count = var.default_security_groups ? 1 : 0

  name        = "${var.elastic_resources_prefix}public-services"
  description = "Входящий трафик из группы безопасности, в которой находится ВМ, на порты 443 (Kibana) и 9200 (Elasticsearch)."
  folder_id   = var.folder_id
  network_id  = var.network_id

  # протокол: TCP;
  # диапазон портов: 22, 443, 9200;
  # тип источника: CIDR;
  # источник: 0.0.0.0/0.
  ingress {
    description    = "SSH"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "Kibana"
    protocol       = "TCP"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description    = "Elasticsearch"
    protocol       = "TCP"
    port           = 9200
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
  # протокол: Any;
  # диапазон портов: 0-65535;
  # тип назначения: CIDR;
  # назначение: 0.0.0.0/0.
  egress {
    protocol       = "Any"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}