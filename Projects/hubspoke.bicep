param vnetName string = 'Test-FW-VN'
param location string = resourceGroup().location
param vNetSettings object = {
  addressPrefixes: [
    {
      name: 'firstPrefix'
      addressPrefix: '10.0.0.0/16'
    }
  ]
  subnets: [
    {
      name: 'AzureFirewallSubnet'
      addressPrefix: '10.0.1.0/24'
    }
    {
      name: 'Workload-SN'
      addressPrefix: '10.0.2.0/24'
    }
  ]
}
param firewallPolicyName string = 'testPolicy'
param firewallName string = 'Test-FW01'
param firewallIPName string = 'fw-pip'
param routeTableName string = 'rt-to-fw'

resource hubVnet 'Microsoft.Network/virtualNetworks@2020-06-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vNetSettings.addressPrefixes[0].addressPrefix
      ]
    }
    subnets: [
      {
        name: vNetSettings.subnets[0].name
        properties: {
          addressPrefix: vNetSettings.subnets[0].addressPrefix
        }
        
      }
      {
        name: vNetSettings.subnets[1].name
        properties: {
          addressPrefix: vNetSettings.subnets[1].addressPrefix
          routeTable: {
            id: routeTable.id
          }
        }
      }
    ]
  }
}

resource routeTable 'Microsoft.Network/routeTables@2021-05-01' = {
  name: routeTableName
  location: location
  properties: {
    disableBgpRoutePropagation: true
    routes: [
      {
        name: routeTableName
        properties: {
          addressPrefix: '0.0.0.0/0'
          nextHopIpAddress: '10.0.1.4'
          nextHopType: 'VirtualAppliance'
        }
        type: 'string'
      }
    ]
  }
}

resource firewallIPconfig 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: firewallIPName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }

}

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2021-05-01' = {
  name: firewallPolicyName
  location: location
  properties: {
    sku: {
      tier: 'Basic'
    }
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2021-05-01' = {
  name: firewallName
  location: location
  properties: {
    firewallPolicy: {
      id: firewallPolicy.id
    }
    sku: {
      name: 'AZFW_VNet'
      tier: 'Basic'
    }
    ipConfigurations: [
      {
        name: 'publicIPconfiguration'
        properties: {
          publicIPAddress: {
            id: firewallIPconfig.id
          }
          subnet: {
            id: hubVnet.properties.subnets[0].id
          }
        }
      }
    ]
  }

}
