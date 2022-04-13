param bastionName string = ''
param location string = resourceGroup().location
param sku string = 'Standard'
param bastionPublicIPId string = ''
param bastionSubnetId string = ''

resource bastionHost 'Microsoft.Network/bastionHosts@2021-05-01' = {
  name: bastionName
  location: location
  sku: {
    name: sku
  }
  properties: {
    disableCopyPaste: false
    enableFileCopy: true
    enableIpConnect: true
    enableShareableLink: false
    enableTunneling: true
    ipConfigurations: [
      {
        id: 'string'
        name: 'bastionIpConf'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: bastionPublicIPId
          }
          subnet: {
            id: bastionSubnetId
          }
        }
      }
    ]
    scaleUnits: 2
  }
}
