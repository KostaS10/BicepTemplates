param location string = resourceGroup().location
param keyvaultNameValue string = ''

var keyvaultName = '${keyvaultNameValue}${uniqueString(resourceGroup().id)}'

resource keyVault 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyvaultName
  location: location
  properties: {
    sku: {
      family: 'A'
      name: 'standard'
    }
    tenantId: subscription().id
  }
}
