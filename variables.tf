# Basic parameters

variable "folder_id" {
  description = "The ID of the folder that the Elasticsearch cluster belongs to."
  type        = string
}

variable "name" {
  description = "Name of the Elasticsearch cluster."
  type        = string
}

variable "description" {
  description = "Elasticsearch cluster description"
  type        = string
}

variable "environment" {
  description = "Elasticsearch version"
  type        = string
  default     = "PRODUCTION"
}

variable "elastic_version" {
  description = "Version of Elasticsearch."
  type        = string
}

variable "elastic_edition" {
  description = "Edition of Elasticsearch."
  type        = string
  default     = "Basic"
}

variable "plugins" {
  description = "A set of Elasticsearch plugins to install."
  type        = list(string)
  default     = []
}

variable "labels" {
  description = "A set of key/value label pairs to assign to the Elasticsearch cluster."
  type        = map(string)
  default     = {}
}

variable "network_id" {
  description = "ID of the network, to which the Elasticsearch cluster belongs."
  type        = string
}

variable "admin_password" {
  description = "Password for admin user of Elasticsearch."
  type        = string
}

variable "deletion_protection" {
  description = "Inhibits deletion of the cluster."
  type        = bool
  default     = true
}


# Service account

variable "service_account_id" {
  description = <<-EOF
  ID of existing service account to be used for Elasticsearch cluster.
  EOF
  type        = string
  default     = null
}

variable "service_account_name" {
  description = <<-EOF
  Name of service account to create to be used for provisioning Elasticsearch cluster.
  `service_account_name` is ignored if `service_account_id` is set.
  EOF
  type        = string
  default     = null
}


# Security Groups

variable "default_security_groups" {
  description = "Create default security groups"
  type        = bool
  default     = true
}

variable "security_group_ids" {
  description = "A set of ids of security groups assigned to hosts of the cluster."
  type        = set(string)
  default     = null
}

variable "vpn_ips" {
  description = "List of VPN IPs to access Elasticsearch cluster"
  type        = list(string)
  default     = []
}

# A host of the Elasticsearch cluster.

variable "host_name" {
  description = "User defined host name."
  type        = string
}

variable "host_zone" {
  description = "The availability zone where the Elasticsearch host will be created."
  type        = string
}

variable "host_type" {
  description = "The type of the host to be deployed. Can be either DATA_NODE or MASTER_NODE."
  type        = string
}

variable "host_subnet_id" {
  description = <<-EOF
  The ID of the subnet, to which the host belongs.
  The subnet must be a part of the network to which the cluster belongs.
  EOF
  type        = string
}

variable "host_assign_public_ip" {
  description = <<-EOF
  Sets whether the host should get a public IP address on creation.
  Can be either true or false.
  EOF
  type        = bool
  default     = false
}


# Maintaince

variable "maintenance_type" {
  description = "Type of maintenance window. Can be either ANYTIME or WEEKLY."
  type        = string
  default     = "WEEKLY"
}

variable "maintenance_hour" {
  description = "Hour of day in UTC time zone (1-24) for maintenance window if window type is weekly."
  type        = number
  default     = 3
}

variable "maintenance_day" {
  description = <<-EOF
  Day of week for maintenance window if window type is weekly.
  Possible values: MON, TUE, WED, THU, FRI, SAT, SUN.
  EOF
  type        = string
  default     = "SUN"
}

# Master node

variable "master_node_resource_preset_id" {
  description = "The ID of the preset for computational resources available to a host (CPU, memory etc.)."
  type        = string
  default     = "s2.micro"
}
variable "master_node_disk_type_id" {
  description = "Type of the storage of Elasticsearch hosts."
  type        = string
  default     = "network-ssd"
}
variable "master_node_disk_size" {
  description = "Volume of the storage available to a host, in gigabytes."
  type        = number
  default     = 20
}

# Data node

variable "data_node_resource_preset_id" {
  description = "The ID of the preset for computational resources available to a host (CPU, memory etc.)."
  type        = string
  default     = "s2.micro"
}
variable "data_node_disk_type_id" {
  description = "Type of the storage of Elasticsearch hosts."
  type        = string
  default     = "network-ssd"
}
variable "data_node_disk_size" {
  description = "Volume of the storage available to a host, in gigabytes."
  type        = number
  default     = 20
}


# Bastion

variable "create_elastic_bastion" {
  description = "Create VM for Elasticsearch cluster Bastion"
  type        = bool
  default     = false
}

variable "bastion_image_id" {
  description = "A disk image to initialize this disk from."
  type        = string
}

variable "bastion_platform_id" {
  description = "The type of virtual machine to create."
  type        = string
  default     = "standard-v1"
}

variable "bastion_name" {
  description = "Description of the bastion instance."
  type        = string
}

variable "bastion_hostname" {
  description = "Host name for the bastion instance."
  type        = string
  default     = "elastic-bastion"
}

variable "bastion_description" {
  description = "Description of the bastion instance."
  type        = string
  default     = "Bastion for ElasticSearch cluster"
}

variable "bastion_disk_type" {
  description = "Disk type."
  type        = string
  default     = "network-hdd"
}

variable "bastion_disk_size" {
  description = "Size of the disk in GB."
  type        = number
  default     = 10
}

variable "bastion_cores" {
  description = "CPU cores for the instance."
  type        = number
  default     = 2
}

variable "bastion_memory" {
  description = "Memory size in GB."
  type        = number
  default     = 1
}

variable "bastion_core_fraction" {
  description = "Specifies baseline performance for a core as a percent."
  type        = number
  default     = 20
}

variable "bastion_internal_ip" {
  description = "Elasticsearch Bastion IP"
  type        = string
  default     = null
}

variable "bastion_labels" {
  description = "A set of key/value label pairs to assign to the Elasticsearch bastion."
  type        = map(string)
  default = {
    app = "elasticsearch"
  }
}





variable "elastic_resources_prefix" {
  description = "Prefix for names of resources"
  type        = string
  default     = "elastic"
}






variable "local_subnet_ranges" {
  description = ""
  type        = list(string)
  default     = []
}

