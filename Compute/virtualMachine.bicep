param location string = resourceGroup().location
param vmName string = 'dtHoneypot'

resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-11-01' = {
  location: location
  name: vmName
}
