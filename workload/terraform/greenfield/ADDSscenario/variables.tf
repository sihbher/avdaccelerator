# Create a storage allow list of IP Addresses
variable "allow_list_ip" {
  type        = list(string)
  description = "List of allowed IP Addresses"
}

variable "avdLocation" {
  description = "Location of the resource group."
}

variable "avdshared_subscription_id" {
  type        = string
  description = "Spoke Subscription id"
}

variable "dag" {
  type        = string
  description = "Name of the Azure Virtual Desktop desktop application group"
}

variable "dns_servers" {
  type        = list(string)
  description = "Custom DNS configuration"
}

variable "domain_guid" {
  type        = string
  description = "Domain GUID"
}

variable "domain_name" {
  type        = string
  description = "Name of the domain to join"
}

variable "domain_sid" {
  type        = string
  description = "Domain SID"
}

variable "domain_user" {
  type        = string
  description = "Username for domain join (do not include domain name as this is appended)"
}

variable "environment" {
  type        = string
  description = "Environment name sets the type of environment (Development (dev), Test (test), Production (prod)) that will be deployed, this information will be use as part of the resources naming."
}

variable "fw_policy" {
  type        = string
  description = "Name of the firewall policy"
}

variable "hostpool" {
  type        = string
  description = "Name of the Azure Virtual Desktop host pool"
}

variable "hub_connectivity_rg" {
  type        = string
  description = "The resource group for hub connectivity resources"
}

variable "hub_dns_zone_rg" {
  description = "The resource group for the hub DNS zone"
}

variable "hub_subscription_id" {
  type        = string
  description = "Hub Subscription id"
}

variable "hub_vnet" {
  type        = string
  description = "Name of domain controller vnet"
}

variable "identity_rg" {
  type        = string
  description = "Name of the Resource group in which to identity resources are deployed"
}

variable "identity_subscription_id" {
  type        = string
  description = "identity Subscription id"
}

variable "identity_vnet" {
  type        = string
  description = "Name of the vnet in which to identity resources are deployed"
}

variable "local_admin_username" {
  type        = string
  description = "local admin username"
}

variable "netbios_domain_name" {
  type        = string
  description = "Netbios domain name"
}

# variables for firewall policy 
variable "next_hop_ip" {
  type        = string
  description = "Next hop IP address"
}

variable "nsg" {
  type        = string
  description = "Name of the nsg"
}

variable "offer" {
  type        = string
  description = "Offer of the image"
}

variable "ou_path" {
  description = "Distinguished name of the organizational unit for the session host"
}

variable "pag" {
  type        = string
  description = "Name of the Azure Virtual Desktop remote application group"
}

variable "personalpool" {
  type        = string
  description = "Name of the Azure Virtual Desktop host pool"
}

variable "pesnet" {
  type        = string
  description = "Name of subnet"
}

variable "pesubnet_range" {
  type        = list(string)
  description = "Address range for private endpoints subnet"
}

variable "prefix" {
  type        = string
  description = "Prefix of the name under 5 characters"

  validation {
    condition     = length(var.prefix) < 5 && lower(var.prefix) == var.prefix
    error_message = "The prefix value must be lowercase and < 4 chars."
  }
}

variable "publisher" {
  type        = string
  description = "Publisher of the image"
}

variable "pworkspace" {
  type        = string
  description = "Name of the Azure Virtual Desktop Personal workspace"
}

variable "rag" {
  type        = string
  description = "Name of the Azure Virtual Desktop remote application group"
}

variable "raghostpool" {
  type        = string
  description = "Name of the Azure Virtual Desktop remote app group"
}

variable "ragworkspace" {
  type        = string
  description = "Name of the Azure Virtual Desktop workspace"
}

variable "rdsh_count" {
  description = "Number of AVD machines to deploy"
}

variable "rg_avdi" {
  type        = string
  description = "Name of the Resource group in which to deploy avd service objects"
}

variable "rg_network" {
  type        = string
  description = "Name of the Resource group in which to deploy network resources"
}

variable "rg_pool" {
  description = "Resource group AVD machines will be deployed to"
}

variable "rg_shared_name" {
  type        = string
  description = "Name of the Resource group in which to deploy shared resources"
}

# Resource Groups
variable "rg_so" {
  type        = string
  description = "Name of the Resource group in which to deploy service objects"
}

variable "rg_stor" {
  type        = string
  description = "Name of the Resource group in which to deploy storage"
}

variable "rt" {
  type        = string
  description = "Name of the route table"
}

variable "scplan" {
  type        = string
  description = "Name of the session host scaling plan"
}

variable "sku" {
  type        = string
  description = "SKU of the image"
}

variable "snet" {
  type        = string
  description = "Name of subnet"
}

variable "spoke_subscription_id" {
  type        = string
  description = "Spoke Subscription id"
}

variable "subnet_range" {
  type        = list(string)
  description = "Address range for session host subnet"
}

variable "user_group_name" {
  type        = string
  description = "Microsoft Entra ID Group for AVD users"
}

variable "vm_size" {
  description = "Size of the machine to deploy"
}

variable "vnet" {
  type        = string
  description = "Name of avd vnet"
}

variable "vnet_range" {
  type        = list(string)
  description = "Address range for deployment VNet"
}

variable "workspace" {
  type        = string
  description = "Name of the Azure Virtual Desktop workspace"
}

variable "domain_password" {
  type        = string
  default     = "ChangeMe123$"
  description = "Password of the user to authenticate with the domain"
  sensitive   = true
}

variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetry.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "enable_nic_diagnostics" {
  description = "Enable or disable diagnostic settings for network interfaces"
  type        = bool
  default     = true
}


variable "flow_logs_config" {

  type = object({
    retention_days              = number # How many days to retain flow logs
    traffic_analytics_enabled   = bool   # Enable or disable Network Traffic Analytics
    traffic_analytics_interval  = number # Interval in minutes to process analytics
    network_watcher_name        = string # Name of the Network Watcher instance
    network_watcher_rg_name     = string # Resource group containing the Network Watcher
    storage_account_tier        = string # Performance tier for storage account
    storage_account_replication = string # Data redundancy option for storage account
  })
  default = null

  description = <<DESCRIPTION
Configuration for the Network Flow Logs. Set to null to disable flow logs. This includes the following properties:
- `retention_days` - The number of days to retain flow log data. Must be between 1 and 365 days.
- `traffic_analytics_enabled` - Whether to enable Traffic Analytics for advanced processing of flow log data.
- `traffic_analytics_interval` - The interval in minutes at which Traffic Analytics processes flow log data. Must be either 10 or 60 minutes.
- `network_watcher_name` - The name of the Network Watcher resource that will manage the flow logs.
- `network_watcher_rg_name` - The resource group containing the Network Watcher resource.
- `storage_account_tier` - The performance tier for the storage account used to store flow logs. Must be either "Standard" or "Premium".
- `storage_account_replication` - The type of replication to use for the storage account. Must be one of: "LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS".
DESCRIPTION

  validation {
    condition     = var.flow_logs_config == null ? true : var.flow_logs_config.retention_days >= 1 && var.flow_logs_config.retention_days <= 365
    error_message = "Retention days must be between 1 and 365."
  }

  validation {
    condition     = var.flow_logs_config == null ? true : var.flow_logs_config.traffic_analytics_interval == 10 || var.flow_logs_config.traffic_analytics_interval == 60
    error_message = "Traffic analytics interval must be either 10 or 60 minutes."
  }

  validation {
    condition     = var.flow_logs_config == null ? true : contains(["Standard", "Premium"], var.flow_logs_config.storage_account_tier)
    error_message = "Storage account tier must be either 'Standard' or 'Premium'."
  }

  validation {
    condition     = var.flow_logs_config == null ? true : contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.flow_logs_config.storage_account_replication)
    error_message = "Storage account replication must be one of: LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS."
  }
}