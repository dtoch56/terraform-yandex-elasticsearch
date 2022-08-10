output "cluster_id" {
  description = "ID of a new Elasticsearch cluster."
  value = yandex_mdb_elasticsearch_cluster.elastic.id
}

output "service_account_id" {
  description = <<-EOF
  ID of service account used for provisioning Elasticsearch cluster
  EOF
  value = local.service_account_id
}
