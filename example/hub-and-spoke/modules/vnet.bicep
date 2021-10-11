param name string
param location string
param addressPrefix string

@description('A list of objects with the following properties: name, addressPrefix')
param subnets array

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

output vnetName string = vnet.name
