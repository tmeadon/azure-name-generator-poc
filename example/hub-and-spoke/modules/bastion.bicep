param bastionName string
param pipName string
param location string
param vnetName string
param vnetResourceGroup string

resource pip 'Microsoft.Network/publicIPAddresses@2019-11-01' = {
  name: pipName
  location: location
  properties: {
    publicIPAllocationMethod: 'Static'
  }
  sku: {
    name: 'Standard'
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: vnetName
  scope: resourceGroup(vnetResourceGroup)

  resource bastionSubnet 'subnets' existing = {
    name: 'AzureBastionSubnet'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2020-11-01' = {
  name: bastionName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          publicIPAddress: {
            id: pip.id
          }
          subnet: {
            id: vnet::bastionSubnet.id
          }
        }
      }
    ]
  }
}
