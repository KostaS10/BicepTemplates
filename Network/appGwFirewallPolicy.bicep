param policyName string = ''
param ruleSetType string = 'OWASP'
param ruleSetVersion string = '3.1'
param mode string = 'Detection'
param state string = 'Enabled'
param location string = resourceGroup().location


resource fwPolicy 'Microsoft.Network/ApplicationGatewayWebApplicationFirewallPolicies@2021-05-01' = {
  name: policyName
  location: location
  properties: {
    managedRules: {
      managedRuleSets: [
        {
          ruleSetType: ruleSetType
          ruleSetVersion: ruleSetVersion
        }
      ]
    }
    policySettings: {
      fileUploadLimitInMb: 100
      maxRequestBodySizeInKb: 128
      mode: mode
      requestBodyCheck: true
      state: state
    }
  }
}
