param name string
param location string
param addressPrefix string = '10.0.0.0/16'
param subnets array = [
  {
    name: 'subnet0'
    addressPrefix: '10.0.0.0/24'
  }
]

resource vnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [for item in subnets: {
      name: item.name
      properties: {
        addressPrefix: item.addressPrefix
      }
    }]
  }
}

output subnetIds array = [for (item, index) in subnets: vnet.properties.subnets[index].id ]
