@description('Front Door resource Name')
param frontDoorName string = 'SALESPRO'
param frontendEndpointName string = 'salespro-dev'
param backendPoolName string = 'backendpool01'

resource frontDoor 'Microsoft.Network/frontDoors@2020-05-01' = {

  name: frontDoorName
  location: 'global'
  properties: {
    enabledState: 'Enabled'
    friendlyName: frontDoorName
    frontendEndpoints: [
      {
        name: frontendEndpointName
        properties: {
          hostName: '${frontendEndpointName}.azurefd.net'
        }
      }
    ]
    loadBalancingSettings: [
      {
        name: 'loadBalancingSetting'
        properties: {
          sampleSize: 4
          successfulSamplesRequired: 2
        }
      }
    ]

    healthProbeSettings: [
      {
        name: 'healthProbeSetting'
        properties: {
          path: '/'
          protocol: 'Https'
          intervalInSeconds: 120
        }
      }
    ]
    backendPools: [
      {
        name: backendPoolName
      }
    ]
  }
}
