param name string
param pipName string
param location string
param vnetName string
param vnetResourceGroup string

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: vnetName
  scope: resourceGroup(vnetResourceGroup)

  resource firewallSubnet 'subnets' existing = {
    name: 'AzureFirewallSubnet'
  }
}

resource pip 'Microsoft.Network/publicIPAddresses@2020-11-01' = {
  name: pipName
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2020-11-01' = {
  name: name
  location: location
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet::firewallSubnet.id
          }
          publicIPAddress: {
            id: pip.id
          }
        }
      }
    ]
  }
}
