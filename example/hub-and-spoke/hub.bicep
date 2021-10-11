param location string
param shortLocation string

module naming 'modules/naming.bicep' = {
  name: 'hub-naming'
  params: {
    app: 'hub'
    env: 'prd'
    location: shortLocation
  }
}

module vnet 'modules/vnet.bicep' = {
  name: 'hub-vnet'
  params: {
    addressPrefix: '10.0.0.0/16'
    location: location
    name: naming.outputs.vnet
    subnets: [
      {
        name: 'AzureFirewallSubnet'
        addressPrefix: '10.0.0.0/26'
      }
      {
        name: 'AzureBastionSubnet'
        addressPrefix: '10.0.0.64/27'
      }
    ]
  }
}

module firewall 'modules/firewall.bicep' = {
  name: 'hub-fw'
  params: {
    location: location
    name: naming.outputs.firewall
    pipName: naming.outputs.firewallPip
    vnetName: vnet.outputs.vnetName
    vnetResourceGroup: resourceGroup().name
  }
}

module bastion 'modules/bastion.bicep' = {
  name: 'hub-bst'
  params: {
    bastionName: naming.outputs.bastion 
    location: location
    pipName: naming.outputs.bastionPip
    vnetName: vnet.outputs.vnetName
    vnetResourceGroup: resourceGroup().name
  }
}

output vnetName string = vnet.outputs.vnetName
