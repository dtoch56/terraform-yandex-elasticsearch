# Yandex.Cloud Elasticsearch module

Creates a Yandex Managed Service for Elasticsearch in Yandex.Cloud.

## Basic example

To create an Elasticsearch cluster named `my-es` in Yandex.Cloud folder with id `xxx000xxx000xxx000xx`:

```hcl
module "elasticsearch" {
  source  = "dtoch56/ansible/yandex"

  cloud_id    = "xxx000xxx000xxx000xx"
  folder_name = "my-folder"
}
```

## Requirements

| Name                                            | Version |
|-------------------------------------------------|---------|
| [terraform](https://www.terraform.io/downloads) | >= 1.2  |

## Providers

| Name                                                                                    | Version |
|-----------------------------------------------------------------------------------------|---------|
| [yandex-cloud](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs) | >= 0.77 |

## Modules

No modules.

## Resources

| Name                                                                                                                                                                    | Type     |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [mdb_elasticsearch_cluster](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_elasticsearch_cluster)                                | resource |
| [yandex_iam_service_account](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/iam_service_account)                                     | resource |

## Inputs

| Name                          | Description                                                                                                                                               | Type     | Required | Default |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------|:--------:|---------|

## Outputs

| Name                    | Description                                                                                           |
|-------------------------|-------------------------------------------------------------------------------------------------------|
| cluster_id              | ID of a new Elasticsearch cluster.                                                                    | 
| service_account_id      | ID of service account used for provisioning Compute Cloud and VPC resources for Elasticsearch cluster | 



