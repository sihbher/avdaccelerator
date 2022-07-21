targetScope = 'subscription'

// ========== //
// Parameters //
// ========== //
@minLength(2)
@maxLength(4)
@description('Required. The name of the resource group to deploy.')
param deploymentPrefix string = ''

@description('Optional. Location where to deploy compute services. (Default: eastus2)')
param avdSessionHostLocation string = 'eastus2'

@description('Optional. Location where to deploy AVD management plane. (Default: eastus2)')
param avdManagementPlaneLocation string = 'eastus2'

@description('Required. AVD workload subscription ID, multiple subscriptions scenario.')
param avdWorkloadSubsId string = ''

@description('Required. Azure Virtual Desktop Enterprise Application object ID. ')
param avdEnterpriseAppObjectId string = ''

@description('Required. AVD session host local username.')
param avdVmLocalUserName string = ''

@description('Required. AVD session host local password.')
@secure()
param avdVmLocalUserPassword string = ''

@description('Required. AD domain name.')
param avdIdentityDomainName string = ''

@description('Required. AVD session host domain join username.')
param avdDomainJoinUserName string = ''

@description('Required. AVD session host domain join password.')
@secure()
param avdDomainJoinUserPassword string = ''

@description('Optional. OU path to join AVd VMs. (Default: "")')
param avdOuPath string = ''

@allowed([
    'Personal'
    'Pooled'
])
@description('Optional. AVD host pool type. (Default: Pooled)')
param avdHostPoolType string = 'Pooled'

@allowed([
    'Automatic'
    'Direct'
])
@description('Optional. AVD host pool type. (Default: Automatic)')
param avdPersonalAssignType string = 'Automatic'

@allowed([
    'BreadthFirst'
    'DepthFirst'
])
@description('Optional. AVD host pool load balacing type. (Default: BreadthFirst)')
param avdHostPoolLoadBalancerType string = 'BreadthFirst'

@description('Optional. AVD host pool maximum number of user sessions per session host. (Default: 15)')
param avhHostPoolMaxSessions int = 15

@description('Optional. AVD host pool start VM on Connect. (Default: true)')
param avdStartVmOnConnect bool = true

@description('Optional. Create custom Start VM on connect role. (Default: true)')
param createStartVmOnConnectCustomRole bool = true

@description('Optional. AVD deploy remote app application group. (Default: false)')
param avdDeployRappGroup bool = false

@description('Optional. AVD host pool Custom RDP properties. (Default: audiocapturemode:i:1;audiomode:i:0;drivestoredirect:s:;redirectclipboard:i:1;redirectcomports:i:1;redirectprinters:i:1;redirectsmartcards:i:1;screen mode id:i:2)')
param avdHostPoolRdpProperties string = 'audiocapturemode:i:1;audiomode:i:0;drivestoredirect:s:;redirectclipboard:i:1;redirectcomports:i:1;redirectprinters:i:1;redirectsmartcards:i:1;screen mode id:i:2'

@description('Optional. Create new virtual network. (Default: true)')
param createAvdVnet bool = true

@description('Optional. Existing virtual network subnet. (Default: "")')
param existingVnetSubnetResourceId string = ''

@description('Required. Existing hub virtual network for perring.')
param existingHubVnetResourceId string = ''

@description('Optional. AVD virtual network address prefixes. (Default: 10.10.0.0/23)')
param avdVnetworkAddressPrefixes string = '10.10.0.0/23'

@description('Optional. AVD virtual network subnet address prefix. (Default: 10.10.0.0/23)')
param avdVnetworkSubnetAddressPrefix string = '10.10.0.0/23'

@description('Required. custom DNS servers IPs.')
param customDnsIps string = ''

@description('Optional. Use Azure private DNS zones for private endpoints. (Default: false)')
param avdVnetPrivateDnsZone bool = false

@description('Optional. Use Azure private DNS zones for private endpoints. (Default: false)')
param avdVnetPrivateDnsZoneFilesId string = ''

@description('Optional. Use Azure private DNS zones for private endpoints. (Default: false)')
param avdVnetPrivateDnsZoneKeyvaultId string = ''

@description('Optional. Does the hub contains a virtual network gateway. (Default: false)')
param vNetworkGatewayOnHub bool = false

@description('Optional. Deploy Fslogix setup. (Default: true)')
param createAvdFslogixDeployment bool = true

@description('Optional. Fslogix file share size. (Default: 5TB)')
param avdFslogixFileShareQuotaSize int = 512

@description('Optional. Deploy new session hosts. (Default: true)')
param avdDeploySessionHosts bool = true

@minValue(1)
@maxValue(999)
@description('Optional. Cuantity of session hosts to deploy. (Default: 1)')
param avdDeploySessionHostsCount int = 1

@description('Optional. The session host number to begin with for the deployment. This is important when adding virtual machines to ensure the names do not conflict. (Default: 0)')
param avdSessionHostCountIndex int = 0

@description('Optional. Creates an availability zone and adds the VMs to it. Cannot be used in combination with availability set nor scale set. (Defualt: true)')
param avdUseAvailabilityZones bool = true

@description('Optional. Sets the number of fault domains for the availability set. (Defualt: 3)')
param avdAsFaultDomainCount int = 2

@description('Optional. Sets the number of update domains for the availability set. (Defualt: 5)')
param avdAsUpdateDomainCount int = 5

@description('Optional. Storage account SKU for FSLogix storage. Recommended tier is Premium LRS or Premium ZRS. (when available) (Defualt: Premium_LRS)')
param fslogixStorageSku string = 'Premium_LRS'

@description('Optional. This property can be used by user in the request to enable or disable the Host Encryption for the virtual machine. This will enable the encryption for all the disks including Resource/Temp disk at host itself. For security reasons, it is recommended to set encryptionAtHost to True. Restrictions: Cannot be enabled if Azure Disk Encryption (guest-VM encryption using bitlocker/DM-Crypt) is enabled on your VMs.')
param encryptionAtHost bool = false

@description('Optional. Session host VM size. (Defualt: Standard_D2s_v3)')
param avdSessionHostsSize string = 'Standard_D2s_v3'

@description('Optional. OS disk type for session host. (Defualt: Standard_LRS)')
param avdSessionHostDiskType string = 'Standard_LRS'

@allowed([
    'win10_21h2_office'
    'win10_21h2'
    'win11_21h2_office'
    'win11_21h2'
])
@description('Optional. AVD OS image source. (Default: win10-21h2)')
param avdOsImage string = 'win10_21h2'

@description('Optional. Set to deploy image from Azure Compute Gallery. (Default: false)')
param useSharedImage bool = false

@description('Optional. Source custom image ID. (Default: "")')
param avdImageTemplataDefinitionId string = ''

@description('Optional. OU name for Azure Storage Account. It is recommended to create a new AD Organizational Unit (OU) in AD and disable password expiration policy on computer accounts or service logon accounts accordingly.  (Default: "")')
param storageOuName string = ''

@description('Optional. If OU for Azure Storage needs to be created - set to true and ensure the domain join credentials have priviledge to create OU and create computer objects or join to domain. (Default: "")')
param createOuForStorage bool = false

@description('Do not modify, used to set unique value for resource deployment.')
param time string = utcNow()

@description('Enable usage and telemetry feedback to Microsoft.')
param enableTelemetry bool = true

// =========== //
// Variable declaration //
// =========== //
// Resource naming
var deploymentPrefixLowercase = toLower(deploymentPrefix)
var avdSessionHostLocationLowercase = toLower(avdSessionHostLocation)
var avdManagementPlaneLocationLowercase = toLower(avdManagementPlaneLocation)
var avdSessionHostLocationAcronym = locationAcronyms[avdSessionHostLocationLowercase]
var avdManagementPlaneLocationAcronym = locationAcronyms[avdManagementPlaneLocation]
var locationAcronyms = {
    eastasia: 'eas'
    southeastasia: 'seas'
    centralus: 'cus'
    eastus: 'eus'
    eastus2: 'eus2'
    westus: 'wus'
    northcentralus: 'ncus'
    southcentralus: 'scus'
    northeurope: 'neu'
    westeurope: 'weu'
    japanwest: 'jpw'
    japaneast: 'jpe'
    brazilsouth: 'drs'
    australiaeast: 'aue'
    australiasoutheast: 'ause'
    southindia: 'sin'
    centralindia: 'cin'
    westindia: 'win'
    canadacentral: 'cac'
    canadaeast: 'cae'
    uksouth: 'uks'
    ukwest: 'ukw'
    westcentralus: 'wcus'
    westus2: 'wus2'
    koreacentral: 'krc'
    koreasouth: 'krs'
    francecentral: 'frc'
    francesouth: 'frs'
    australiacentral: 'auc'
    australiacentral2: 'auc2'
    uaecentral: 'aec'
    uaenorth: 'aen'
    southafricanorth: 'zan'
    southafricawest: 'zaw'
    switzerlandnorth: 'chn'
    switzerlandwest: 'chw'
    germanynorth: 'den'
    germanywestcentral: 'dewc'
    norwaywest: 'now'
    norwayeast: 'noe'
    brazilsoutheast: 'brse'
    westus3: 'wus3'
    swedencentral: 'sec'
}
var avdNamingUniqueStringSixChar = take('${uniqueString(avdWorkloadSubsId, deploymentPrefixLowercase, time)}', 6)
var avdServiceObjectsRgName = 'rg-${avdManagementPlaneLocationAcronym}-avd-${deploymentPrefixLowercase}-service-objects' // max length limit 90 characters
var avdNetworkObjectsRgName = 'rg-${avdSessionHostLocationAcronym}-avd-${deploymentPrefixLowercase}-network' // max length limit 90 characters
var avdComputeObjectsRgName = 'rg-${avdSessionHostLocationAcronym}-avd-${deploymentPrefixLowercase}-pool-compute' // max length limit 90 characters
var avdStorageObjectsRgName = 'rg-${avdSessionHostLocationAcronym}-avd-${deploymentPrefixLowercase}-storage' // max length limit 90 characters
//var avdSharedResourcesRgName = 'rg-${avdSessionHostLocationAcronym}-avd-shared-resources'
var avdVnetworkName = 'vnet-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdVnetworkSubnetName = 'snet-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdNetworksecurityGroupName = 'nsg-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdRouteTableName = 'route-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdApplicationsecurityGroupName = 'asg-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdVnetworkPeeringName = 'peering-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-${avdNamingUniqueStringSixChar}'
var avdWorkSpaceName = 'vdws-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdHostPoolName = 'vdpool-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdApplicationGroupNameDesktop = 'vdag-desktop-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdApplicationGroupNameRapp = 'vdag-rapp-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-001'
var avdWrklKvName = 'kv-avd-${avdSessionHostLocationAcronym}-${deploymentPrefixLowercase}-${avdNamingUniqueStringSixChar}' // max length limit 24 characters
var avdWrklKvPrivateEndpointName = 'pe-kv-avd-${deploymentPrefixLowercase}-${avdNamingUniqueStringSixChar}-vault'
var avdSessionHostNamePrefix = 'vm-avd-${deploymentPrefix}'
var avdAvailabilitySetNamePrefix = 'avail-avd-${avdSessionHostLocationAcronym}-${deploymentPrefix}'
var fslogixManagedIdentityName = 'id-avd-fslogix-${avdSessionHostLocationAcronym}-${deploymentPrefix}'
var avdFslogixProfileContainerFileShareName = 'fslogix-pc-${deploymentPrefixLowercase}-001'
//var avdFslogixOfficeContainerFileShareName = 'fslogix-oc-${deploymentPrefixLowercase}-001'
var avdFslogixStorageName = 'stavd${deploymentPrefix}${avdNamingUniqueStringSixChar}'
var avdWrklStoragePrivateEndpointName = 'pe-stavd${deploymentPrefixLowercase}${avdNamingUniqueStringSixChar}-file'
var tempStorageDomainJoinVmName = 'vm-fs-dj-${deploymentPrefix}'
var OuStgName = !empty(storageOuName) ? storageOuName : 'Computers'
//

var marketPlaceGalleryWindows = {
    win10_21h2_office: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'office-365'
        sku: 'win10-21h2-avd-m365'
        version: 'latest'
    }

    win10_21h2: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'windows-10'
        sku: 'win10-21h2-avd'
        version: 'latest'
    }

    win11_21h2_office: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'office-365'
        sku: 'win11-21h2-avd-m365'
        version: 'latest'
    }

    win11_21h2: {
        publisher: 'MicrosoftWindowsDesktop'
        offer: 'Windows-11'
        sku: 'win11-21h2-avd'
        version: 'latest'
    }
}

var baseScriptUri = 'https://raw.githubusercontent.com/Azure/avdaccelerator/main/workload/'
var fslogixScriptUri = '${baseScriptUri}scripts/Set-FSLogixRegKeys.ps1'
var fsLogixScript = './Set-FSLogixRegKeys.ps1'
var fslogixSharePath = '\\\\${avdFslogixStorageName}.file.${environment().suffixes.storage}\\${avdFslogixProfileContainerFileShareName}'
var FsLogixScriptArguments = '-volumeshare ${fslogixSharePath}'
var avdAgentPackageLocation = 'https://wvdportalstorageblob.blob.${environment().suffixes.storage}/galleryartifacts/Configuration_01-20-2022.zip'
var storageAccountContributorRoleId = 'b24988ac-6180-42a0-ab88-20f7382dd24c'
var readerRoleId = 'acdd72a7-3385-48ef-bd42-f606fba81ae7'
var dscAgentPackageLocation = 'https://github.com/Azure/avdaccelerator/raw/main/workload/scripts/DSCDomainJoinStorageScripts.zip'
var addStorageToDomainScriptUri = '${baseScriptUri}scripts/Manual-DSC-JoinStorage-to-ADDS.ps1'
var addStorageToDomainScript = './Manual-DSC-JoinStorage-to-ADDS.ps1'
var addStorageToDomainScriptArgs = '-DscPath ${dscAgentPackageLocation} -StorageAccountName ${avdFslogixStorageName} -StorageAccountRG ${avdStorageObjectsRgName} -DomainName ${avdIdentityDomainName} -AzureCloudEnvironment AzureCloud -SubscriptionId ${avdWorkloadSubsId} -DomainAdminUserName ${avdDomainJoinUserName} -DomainAdminUserPassword ${avdDomainJoinUserPassword} -OUName ${OuStgName} -CreateNewOU ${createOuForStorageString} -ShareName ${avdFslogixProfileContainerFileShareName} -ClientId ${deployAvdManagedIdentitiesRoleAssign.outputs.fslogixManagedIdentityClientId} -Verbose'
//var allAvailabilityZones = pickZones('Microsoft.Compute', 'virtualMachines', avdSessionHostLocation, 3)
var createOuForStorageString = string(createOuForStorage)

var resourceGroups = [
    {
        name: avdServiceObjectsRgName
        location: avdManagementPlaneLocation
    }
    {
        name: avdComputeObjectsRgName
        location: avdSessionHostLocation
    }
    /*
    {
        name: avdStorageObjectsRgName
        location: avdSessionHostLocation
    }
    */
]

var telemetryId = 'pid-2ce4228c-d72c-43fb-bb5b-cd8f3ba2138e-${avdManagementPlaneLocation}'

// =========== //
// Deployments //
// =========== //

//  Telemetry Deployment.
resource telemetrydeployment 'Microsoft.Resources/deployments@2021-04-01' = if (enableTelemetry) {
    name: telemetryId
    location: avdManagementPlaneLocation
    properties: {
        mode: 'Incremental'
        template: {
            '$schema': 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#'
            contentVersion: '1.0.0.0'
            resources: []
        }
    }
}

// Resource groups.
// Compute, service objects, network.
module avdBaselineResourceGroups '../../carml/1.2.0/Microsoft.Resources/resourceGroups/deploy.bicep' = [for resourceGroup in resourceGroups: {
    scope: subscription(avdWorkloadSubsId)
    name: 'Deploy-${substring(resourceGroup.name, 10)}-${time}'
    params: {
        name: resourceGroup.name
        location: resourceGroup.location
        enableDefaultTelemetry: false
    }
}]

// Storage.
module avdBaselineStorageResourceGroup '../../carml/1.2.0/Microsoft.Resources/resourceGroups/deploy.bicep' = if (createAvdFslogixDeployment) {
    scope: subscription(avdWorkloadSubsId)
    name: 'Deploy-${avdStorageObjectsRgName}-${time}'
    params: {
        name: avdStorageObjectsRgName
        location: avdSessionHostLocation
        enableDefaultTelemetry: false
    }
}
//

// Optional. Networking.
module avdNetworking 'avd-modules/avd-networking.bicep' = if (createAvdVnet) {
    name: 'Deploy-AVD-Networking-${time}'
    params: {
        avdApplicationsecurityGroupName: avdApplicationsecurityGroupName
        avdComputeObjectsRgName: avdComputeObjectsRgName
        avdNetworkObjectsRgName: avdNetworkObjectsRgName
        avdNetworksecurityGroupName: avdNetworksecurityGroupName
        avdRouteTableName: avdRouteTableName
        avdVnetworkAddressPrefixes: avdVnetworkAddressPrefixes
        avdVnetworkName: avdVnetworkName
        avdVnetworkPeeringName: avdVnetworkPeeringName
        avdVnetworkSubnetName: avdVnetworkSubnetName
        createAvdVnet: createAvdVnet
        vNetworkGatewayOnHub: vNetworkGatewayOnHub
        existingHubVnetResourceId: existingHubVnetResourceId
        avdSessionHostLocation: avdSessionHostLocation
        avdVnetworkSubnetAddressPrefix: avdVnetworkSubnetAddressPrefix
        avdWorkloadSubsId: avdWorkloadSubsId
        customDnsIps: customDnsIps
    }
    dependsOn: [
        avdBaselineResourceGroups
    ]
}

// AVD management plane.
// Host pool and application groups.
module avdHostPoolandAppGroups 'avd-modules/avd-hostpool-app-groups.bicep' = {
    name: 'Deploy-AVD-HostPool-AppGroups-${time}'
    params: {
        avdApplicationGroupNameDesktop: avdApplicationGroupNameDesktop
        avdApplicationGroupNameRapp: avdApplicationGroupNameRapp
        avdDeployRappGroup: avdDeployRappGroup
        avdHostPoolName: avdHostPoolName
        avdHostPoolRdpProperties: avdHostPoolRdpProperties
        avdHostPoolLoadBalancerType: avdHostPoolLoadBalancerType
        avdHostPoolType: avdHostPoolType
        avhHostPoolMaxSessions: avhHostPoolMaxSessions
        avdPersonalAssignType: avdPersonalAssignType
        avdManagementPlaneLocation: avdManagementPlaneLocation
        avdServiceObjectsRgName: avdServiceObjectsRgName
        avdStartVmOnConnect: avdStartVmOnConnect
        avdWorkloadSubsId: avdWorkloadSubsId
    }
    dependsOn: [
        avdBaselineResourceGroups
    ]
}

// Workspace.
module avdWorkSpace '../../carml/1.2.0/Microsoft.DesktopVirtualization/workspaces/deploy.bicep' = {
    scope: resourceGroup('${avdWorkloadSubsId}', '${avdServiceObjectsRgName}')
    name: 'Deploy-AVD-WorkSpace-${time}'
    params: {
        name: avdWorkSpaceName
        location: avdManagementPlaneLocation
        appGroupResourceIds: avdHostPoolandAppGroups.outputs.avdAppGroupsArray
    }
    dependsOn: [
        avdHostPoolandAppGroups
    ]
}
//

// Identity: managed identities and role assignments.
module deployAvdManagedIdentitiesRoleAssign 'avd-modules/avd-identity.bicep' = if (createAvdFslogixDeployment) {
    name: 'Create-Managed-ID-RoleAssign-${time}'
    params: {
        avdComputeObjectsRgName: avdComputeObjectsRgName
        avdDeploySessionHosts: avdDeploySessionHosts
        avdEnterpriseAppObjectId: avdEnterpriseAppObjectId
        avdManagementPlaneLocation: avdSessionHostLocation
        avdServiceObjectsRgName: avdServiceObjectsRgName
        avdStorageObjectsRgName: avdStorageObjectsRgName
        avdWorkloadSubsId: avdWorkloadSubsId
        createStartVmOnConnectCustomRole: createStartVmOnConnectCustomRole
        fslogixManagedIdentityName: fslogixManagedIdentityName
        readerRoleId: readerRoleId
        storageAccountContributorRoleId: storageAccountContributorRoleId
        createAvdFslogixDeployment: createAvdFslogixDeployment
    }
    dependsOn: [
        avdBaselineResourceGroups
    ]
}

// Key vault.
module avdWrklKeyVault '../../carml/1.2.0/Microsoft.KeyVault/vaults/deploy.bicep' = if (avdDeploySessionHosts) {
    scope: resourceGroup('${avdWorkloadSubsId}', '${avdServiceObjectsRgName}')
    name: 'AVD-Workload-KeyVault-${time}'
    params: {
        name: avdWrklKvName
        location: avdSessionHostLocation
        enableRbacAuthorization: false
        enablePurgeProtection: true
        softDeleteRetentionInDays: 7
        networkAcls: {
            bypass: 'AzureServices'
            defaultAction: 'Deny'
            virtualNetworkRules: []
            ipRules: []
        }
        privateEndpoints: avdVnetPrivateDnsZone ? [
            {
                name: avdWrklKvPrivateEndpointName
                subnetResourceId: createAvdVnet ? '${avdNetworking.outputs.avdVirtualNetworkResourceId}/subnets/${avdVnetworkSubnetName}' : existingVnetSubnetResourceId
                service: 'vault'
                privateDnsZoneResourceIds: [
                    avdVnetPrivateDnsZoneKeyvaultId
                ]
            }
        ] : [
            {
                name: avdWrklKvPrivateEndpointName
                subnetResourceId: createAvdVnet ? '${avdNetworking.outputs.avdVirtualNetworkResourceId}/subnets/${avdVnetworkSubnetName}' : existingVnetSubnetResourceId
                service: 'vault'
            }
        ]
        secrets: {
            secureList: [
                {
                    name: 'avdVmLocalUserPassword'
                    value: avdVmLocalUserPassword
                    contentType: 'Session host local user credentials'
                }
                {
                    name: 'avdVmLocalUserName'
                    value: avdVmLocalUserName
                    contentType: 'Session host local user credentials'
                }
                {
                    name: 'avdDomainJoinUserName'
                    value: avdDomainJoinUserName
                    contentType: 'Domain join credentials'
                }
                {
                    name: 'avdDomainJoinUserPassword'
                    value: avdDomainJoinUserPassword
                    contentType: 'Domain join credentials'
                }
            ]
        }
    }
    dependsOn: [
        avdBaselineResourceGroups
        //updateExistingSubnet
    ]
}

// Call on the KV.
resource avdWrklKeyVaultget 'Microsoft.KeyVault/vaults@2021-06-01-preview' existing = if (avdDeploySessionHosts) {
    name: avdWrklKvName
    scope: resourceGroup('${avdWorkloadSubsId}', '${avdServiceObjectsRgName}')
}

// Storage.
module deployAvdStorageAzureFiles 'avd-modules/avd-storage-azurefiles.bicep' = if (createAvdFslogixDeployment) {
    name: 'Deploy-AVD-Storage-AzureFiles-${time}'
    params: {
        addStorageToDomainScript: addStorageToDomainScript
        addStorageToDomainScriptArgs: addStorageToDomainScriptArgs
        addStorageToDomainScriptUri: addStorageToDomainScriptUri
        avdWrklStoragePrivateEndpointName: avdWrklStoragePrivateEndpointName
        avdApplicationSecurityGroupResourceId: createAvdVnet ? '${avdNetworking.outputs.avdApplicationSecurityGroupResourceId}' : ''
        avdComputeObjectsRgName: avdComputeObjectsRgName
        avdDomainJoinUserName: avdDomainJoinUserName
        avdWrklKvName: avdWrklKvName
        avdServiceObjectsRgName: avdServiceObjectsRgName
        avdFslogixProfileContainerFileShareName: avdFslogixProfileContainerFileShareName
        avdFslogixFileShareQuotaSize: avdFslogixFileShareQuotaSize
        avdFslogixStorageName: avdFslogixStorageName
        avdIdentityDomainName: avdIdentityDomainName
        avdImageTemplataDefinitionId: avdImageTemplataDefinitionId
        avdOuPath: avdOuPath
        avdSessionHostDiskType: avdSessionHostDiskType
        avdSessionHostLocation: avdSessionHostLocation
        avdSessionHostsSize: avdSessionHostsSize
        avdStorageObjectsRgName: avdStorageObjectsRgName
        avdSubnetId: createAvdVnet ? '${avdNetworking.outputs.avdVirtualNetworkResourceId}/subnets/${avdVnetworkSubnetName}' : existingVnetSubnetResourceId
        avdVmLocalUserName: avdVmLocalUserName
        avdVnetPrivateDnsZone: avdVnetPrivateDnsZone
        avdVnetPrivateDnsZoneFilesId: avdVnetPrivateDnsZoneFilesId
        avdWorkloadSubsId: avdWorkloadSubsId
        encryptionAtHost: encryptionAtHost
        fslogixManagedIdentityResourceId: createAvdFslogixDeployment ? deployAvdManagedIdentitiesRoleAssign.outputs.fslogixManagedIdentityResourceId : ''
        avdFslogixFileShareMultichannel: (contains(fslogixStorageSku, 'Premium_LRS') || contains(fslogixStorageSku, 'Premium_ZRS')) ? true : false
        fslogixStorageSku: fslogixStorageSku
        marketPlaceGalleryWindows: marketPlaceGalleryWindows['win10_21h2']
        subnetResourceId: createAvdVnet ? '${avdNetworking.outputs.avdVirtualNetworkResourceId}/subnets/${avdVnetworkSubnetName}' : existingVnetSubnetResourceId
        tempStorageDomainJoinVmName: tempStorageDomainJoinVmName
        useSharedImage: useSharedImage
    }
    dependsOn: [
        avdBaselineResourceGroups
        avdNetworking
        avdWrklKeyVaultget
        avdWrklKeyVault
    ]
}

// Session hosts.
module deployAndConfigureAvdSessionHosts './avd-modules/avd-session-hosts-batch.bicep' = if (avdDeploySessionHosts) {
    name: 'Deploy-and-Configure-AVD-SessionHosts-${time}'
    params: {
        avdAgentPackageLocation: avdAgentPackageLocation
        avdApplicationSecurityGroupResourceId: createAvdVnet ? '${avdNetworking.outputs.avdApplicationSecurityGroupResourceId}' : ''
        avdAsFaultDomainCount: avdAsFaultDomainCount
        avdAsUpdateDomainCount: avdAsUpdateDomainCount
        avdAvailabilitySetNamePrefix: avdAvailabilitySetNamePrefix
        avdComputeObjectsRgName: avdComputeObjectsRgName
        avdDeploySessionHostsCount: avdDeploySessionHostsCount
        avdSessionHostCountIndex: avdSessionHostCountIndex
        avdDomainJoinUserName: avdDomainJoinUserName
        avdWrklKvName: avdWrklKvName
        avdServiceObjectsRgName: avdServiceObjectsRgName
        avdHostPoolName: avdHostPoolName
        avdIdentityDomainName: avdIdentityDomainName
        avdImageTemplataDefinitionId: avdImageTemplataDefinitionId
        avdOuPath: avdOuPath
        avdSessionHostDiskType: avdSessionHostDiskType
        avdSessionHostLocation: avdSessionHostLocation
        avdSessionHostNamePrefix: avdSessionHostNamePrefix
        avdSessionHostsSize: avdSessionHostsSize
        avdSubnetId: createAvdVnet ? '${avdNetworking.outputs.avdVirtualNetworkResourceId}/subnets/${avdVnetworkSubnetName}' : existingVnetSubnetResourceId
        avdUseAvailabilityZones: avdUseAvailabilityZones
        avdVmLocalUserName: avdVmLocalUserName
        avdWorkloadSubsId: avdWorkloadSubsId
        encryptionAtHost: encryptionAtHost
        createAvdFslogixDeployment: createAvdFslogixDeployment
        fslogixManagedIdentityResourceId: createAvdFslogixDeployment ? deployAvdManagedIdentitiesRoleAssign.outputs.fslogixManagedIdentityResourceId : 'none'
        fsLogixScript: fsLogixScript
        FsLogixScriptArguments: FsLogixScriptArguments
        fslogixScriptUri: fslogixScriptUri
        hostPoolToken: avdHostPoolandAppGroups.outputs.hostPooltoken
        marketPlaceGalleryWindows: marketPlaceGalleryWindows[avdOsImage]
        useSharedImage: useSharedImage
    }
    dependsOn: [
        avdBaselineResourceGroups
        avdNetworking
        avdWrklKeyVaultget
        avdWrklKeyVault
    ]
}
