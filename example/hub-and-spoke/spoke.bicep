param appName string
param env string
param location string
param shortLocation string
param addressPrefix string
param subnets array
param hubVnetName string

module naming 'modules/naming.bicep' = {
  name: '${appName}-${env}-spoke-naming'
  params: {
    app: appName
    env: env
    location: shortLocation
  }
}

module vnet 'modules/vnet.bicep' = {
  name: '${appName}-${env}-vnet'
  params: {
    addressPrefix: addressPrefix
    location: location
    name: naming.outputs.vnet
    subnets: subnets
  }
}

module vnetToHubPeering 'modules/peering.bicep' = {
  name: '${appName}-${env}-vnetToHubPeering'
  params: {
    remoteVnetName: hubVnetName
    vnetName: naming.outputs.vnet
  }
  dependsOn: [
    vnet
  ]
}

module hubtoVnetPeering 'modules/peering.bicep' = {
  name: '${appName}-${env}-hubToVnetPeering'
  params: {
    remoteVnetName: naming.outputs.vnet
    vnetName: hubVnetName
  }
  dependsOn: [
    vnet
  ]
}
