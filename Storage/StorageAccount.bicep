param location string = resourceGroup().location
param storageAccountNameValue string = ''


var storageAccountName = '${storageAccountNameValue}${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  kind: 'StorageV2'
  location: location
  name: storageAccountName
  sku: {
    name: 'Standard_LRS' 
  }
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
