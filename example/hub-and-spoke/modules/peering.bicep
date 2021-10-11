param vnetName string
param remoteVnetName string

resource remoteVnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: remoteVnetName
}

resource vnet 'Microsoft.Network/virtualNetworks@2020-11-01' existing = {
  name: vnetName
  
  resource peering 'virtualNetworkPeerings' = {
    name: '${vnetName}-${remoteVnetName}'
    properties: {
      allowForwardedTraffic: true
      remoteVirtualNetwork: {
        id: remoteVnet.id
      }
    }
  }
}
