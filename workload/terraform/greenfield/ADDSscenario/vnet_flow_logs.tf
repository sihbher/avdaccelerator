# ----------------------------------------
# Network Flow Logs Configuration
# ----------------------------------------

# Determine if flow logs are enabled based on whether configuration was provided
locals {
  # Flow logs are enabled when the config is provided and not null
  enable_flow_logs = var.flow_logs_config != null
}

# ----------------------------------------
# Network Watcher Data Source
# ----------------------------------------
# Retrieve the Network Watcher instance for the region where flow logs will be created
# This assumes a Network Watcher exists in the specified resource group or in the default
# Azure-created "NetworkWatcher_[region]" format
data "azurerm_network_watcher" "network_watcher" {
  count               = local.enable_flow_logs ? 1 : 0
  
  # Use provided Network Watcher name or fallback to standard naming convention
  name                = var.flow_logs_config.network_watcher_name != "" ? var.flow_logs_config.network_watcher_name : "NetworkWatcher_${lower(var.avdLocation)}"
  resource_group_name = var.flow_logs_config.network_watcher_rg_name
}

# ----------------------------------------
# Storage Account for Flow Logs
# ----------------------------------------
# Create a dedicated storage account to store the flow logs data
# This account uses the configuration specified in flow_logs_config
resource "azurerm_storage_account" "flow_logs_storage" {
  count                    = local.enable_flow_logs ? 1 : 0
  
  # Generate a unique storage account name using the prefix and a random string
  name                     = "stavdflowlogs${var.prefix}${random_string.random.id}"
  resource_group_name      = module.network.rg_name
  location                 = var.avdLocation
  
  # Use the tier and replication settings from the configuration
  account_tier             = var.flow_logs_config.storage_account_tier
  account_replication_type = var.flow_logs_config.storage_account_replication
  
  # Enforce minimum TLS version for security
  min_tls_version          = "TLS1_2"
  
  # Apply the same tags used across the module
  tags                     = local.tags
}

# ----------------------------------------
# Network Watcher Flow Log Resource
# ----------------------------------------
# Create the actual Network Watcher Flow Log resource using the Azure API
# This is implemented using azapi_resource because some advanced configurations
# might not be available in the native Terraform azurerm provider
resource "azapi_resource" "network_watcher_flow_log" {
  count     = local.enable_flow_logs ? 1 : 0
  
  # Resource type and API version
  type      = "Microsoft.Network/networkWatchers/flowLogs@2023-11-01"
  
  # Generate flow log name based on the virtual network name
  name      = "flowlog-${basename(var.vnet)}"
  
  # Link to the parent Network Watcher resource
  parent_id = data.azurerm_network_watcher.network_watcher[0].id

  # Set location and tags
  location = var.avdLocation
  tags     = local.tags

  # Configure the flow log properties
  body = jsonencode({
    properties = {
      # Target the Virtual Network for flow logging
      targetResourceId = module.network.vnet_id
      
      # Reference the storage account created for the flow logs
      storageId        = azurerm_storage_account.flow_logs_storage[0].id
      
      enabled          = true
      retentionPolicy = {
        days    = var.flow_logs_config.retention_days
        enabled = true
      }
      format = {
        type    = "JSON"
        version = 2
      }
      
      # Conditionally configure Traffic Analytics if enabled
      flowAnalyticsConfiguration = var.flow_logs_config.traffic_analytics_enabled ? {
        networkWatcherFlowAnalyticsConfiguration = {
          enabled                  = true
          workspaceId              = module.avm_res_operationalinsights_workspace.resource.workspace_id
          workspaceRegion          = var.avdLocation
          workspaceResourceId      = module.avm_res_operationalinsights_workspace.resource.id
          trafficAnalyticsInterval = var.flow_logs_config.traffic_analytics_interval
        }
      } : null
    }
  })
}