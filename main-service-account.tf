# An account that can be used by user programs to manage a cluster.
locals {
  service_account_name = var.service_account_id == null ? var.service_account_name : null
  service_account_id = try(
    yandex_iam_service_account.es[0].id,
    var.service_account_id
  )
}

resource "yandex_iam_service_account" "es" {
  count = local.service_account_name == null ? 0 : 1

  folder_id   = var.folder_id
  name        = var.service_account_name
  description = "Service account for Elasticsearch cluster"
}
