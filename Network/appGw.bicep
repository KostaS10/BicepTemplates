param location string = resourceGroup().location
param appGwPublicIPName string = ''

resource appGwPublicIP 'Microsoft.Network/publicIPAddresses@2021-05-01' = {
  name: appGwPublicIPName
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
}

