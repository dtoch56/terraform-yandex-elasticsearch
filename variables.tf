# Basic parameters
variable "name" {
  description = "Elasticsearch cluster name"
  type = string
}

variable "description" {
  description = "Elasticsearch cluster description"
  type = string
}

variable "environment" {
  description = "Elasticsearch version"
  type        = string
  default = "PRODUCTION"
}

variable "elastic_version" {
  description = "Elasticsearch version"
  type        = string
}

variable "elastic_edition" {
  description = ""
  type = string
  default = "Basic"
}



# Network settings


variable "folder_id" {
  description = "The ID of the folder that the Elasticsearch cluster belongs to."
  type = string
}

variable "zone" {
  description = ""
  type = string
}

variable "network_id" {
  description = "The ID of the network where the Elasticsearch cluster will be located."
  type = string
}

variable "subnet_id" {
  description = ""
  type = string
}





variable "admin_password" {
  description = "Elasticsearch admin password"
  type        = string
}

variable "create_elastic_bastion" {
  description = "Create VM for Elasticsearch cluster Bastion"
  type        = bool
  default     = false
}

variable "bastion_internal_ip" {
  description = "Elasticsearch Bastion IP"
  type        = string
  default     = null
}

variable "elastic_resources_prefix" {
  description = "Prefix for names of resources"
  type        = string
  default     = "elastic"
}

# Service account
variable "service_account_id" {
  description = <<-EOF
  ID of existing service account to be used for Elasticsearch cluster.
  EOF
  type = string
  default = null
}

variable "service_account_name" {
  description = <<-EOF
  Name of service account to create to be used for provisioning Elasticsearch cluster.
  `service_account_name` is ignored if `service_account_id` is set.
  EOF
  type = string
  default = null
}


# Security Groups
variable "default_security_groups" {
  description = "Create default security groups"
  type = bool
  default = true
}

variable "security_group_ids" {
  description = "List of security group IDs to which the Elasticsearch cluster belongs."
  type = set(string)
  default = null
}

variable "vpn_ips" {
  description = "List of VPN IPs to access Elasticsearch cluster"
  type = list(string)
  default = []
}

variable "local_subnet_ranges" {
  description = ""
  type = list(string)
  default = []
}