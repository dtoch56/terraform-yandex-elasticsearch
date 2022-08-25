output "cluster_id" {
  description = "ID of a new Elasticsearch cluster."
  value       = yandex_mdb_elasticsearch_cluster.elastic.id
}

output "service_account_id" {
  description = <<-EOF
  ID of service account used for provisioning Elasticsearch cluster
  EOF
  value       = local.service_account_id
}

output "hosts" {
  description = "Elasticsearch hosts"
  value = [for h in yandex_mdb_elasticsearch_cluster.elastic.host : h.fqdn]
}
