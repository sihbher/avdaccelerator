locals {
  # Flow logs are enabled when the config is provided
  enable_flow_logs = var.flow_logs_config != null
}

# Get Network Watcher for the region
data "azurerm_network_watcher" "network_watcher" {
  count               = local.enable_flow_logs ? 1 : 0
  name                = var.flow_logs_config.network_watcher_name != "" ? var.flow_logs_config.network_watcher_name : "NetworkWatcher_${lower(var.avdLocation)}"
  resource_group_name = var.flow_logs_config.network_watcher_rg_name
}

# Storage account for flow logs
resource "azurerm_storage_account" "flow_logs_storage" {
  count                    = local.enable_flow_logs ? 1 : 0
  name                     = "stavdflowlogs${var.prefix}${random_string.random.id}"
  resource_group_name      = module.network.rg_name
  location                 = var.avdLocation
  account_tier             = var.flow_logs_config.storage_account_tier
  account_replication_type = var.flow_logs_config.storage_account_replication
  min_tls_version          = "TLS1_2"
  tags                     = local.tags
}

# # Enable Network Flow Logs
# resource "azurerm_network_watcher_flow_log" "flow_logs" {
#   count                = local.enable_flow_logs ? 1 : 0
#   network_watcher_name = data.azurerm_network_watcher.network_watcher[0].name
#   resource_group_name  = data.azurerm_network_watcher.network_watcher[0].resource_group_name
#   name                 = "flow-log-${var.prefix}"

#   network_security_group_id = module.network.vnet_id
#   storage_account_id        = azurerm_storage_account.flow_logs_storage[0].id
#   enabled                   = true
#   version                   = 2

#   retention_policy {
#     enabled = true
#     days    = var.flow_logs_config.retention_days
#   }

#   traffic_analytics {
#     enabled               = var.flow_logs_config.traffic_analytics_enabled
#     workspace_id          = module.avm_res_operationalinsights_workspace.resource.workspace_id
#     workspace_region      = var.avdLocation
#     workspace_resource_id = module.avm_res_operationalinsights_workspace.resource.id
#     interval_in_minutes   = var.flow_logs_config.traffic_analytics_interval
#   }
# }

# Use the AVM Network Watcher module with version 0.3.0
module "network_watcher" {
  source  = "Azure/avm-res-network-networkwatcher/azurerm"
  version = "0.2.0"

  # Only create when flow logs are enabled
  count = local.enable_flow_logs ? 1 : 0

  # Details of existing Network Watcher
  location                = var.avdLocation
  network_watcher_id      = data.azurerm_network_watcher.network_watcher[0].id
  netnetwork_watcher_name = data.azurerm_network_watcher.network_watcher[0].name
  resource_group_name     = data.azurerm_network_watcher.network_watcher[0].resource_group_name

  # Optional parameters
  enable_telemetry = var.enable_telemetry
  tags             = local.tags

  # VNet Flow log configuration
  vnet_flow_logs = {
    "vnet_flow_logs" = {
      network_security_group_id = azurerm_network_security_group.res-0.id # Required for flow logs
      virtual_network_id        = var.flow_logs_config.vnet_id != "" ? var.flow_logs_config.vnet_id : azurerm_virtual_network.res-0.id
      storage_account_id        = azurerm_storage_account.flow_logs_storage[0].id
      enabled                   = true
      version                   = 2

      retention_policy = {
        enabled = true
        days    = var.flow_logs_config.retention_days
      }

      traffic_analytics = {
        enabled               = var.flow_logs_config.traffic_analytics_enabled
        interval_in_minutes   = var.flow_logs_config.traffic_analytics_interval
        workspace_id          = module.avm_res_operationalinsights_workspace.resource.workspace_id
        workspace_region      = var.avdLocation
        workspace_resource_id = module.avm_res_operationalinsights_workspace.resource.id
      }
    }
  }

  # Empty flow_logs as we're using vnet_flow_logs instead
  flow_logs = {}
}