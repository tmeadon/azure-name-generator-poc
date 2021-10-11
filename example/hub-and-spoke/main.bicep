var location = 'uksouth'
var shortLocation = 'uks'

module hub 'hub.bicep' = {
  name: 'hub'
  params: {
    location: location
    shortLocation: shortLocation
  }
}

var spokes = [
  {
    appName: 'app1'
    env: 'dev'
    addressPrefix: '10.1.0.0/24'
    subnets: [
      {
        name: 'subnet0'
        addressPrefix: '10.1.0.0/27'
      }
    ] 
  }
  {
    appName: 'app1'
    env: 'uat'
    addressPrefix: '10.1.1.0/24'
    subnets: [
      {
        name: 'subnet0'
        addressPrefix: '10.1.1.0/27'
      }
    ] 
  }
  {
    appName: 'app1'
    env: 'prd'
    addressPrefix: '10.1.2.0/24'
    subnets: [
      {
        name: 'subnet0'
        addressPrefix: '10.1.2.0/27'
      }
    ] 
  }
]

module spoke 'spoke.bicep' = [for item in spokes: {
  name: 'spoke-${item.appName}-${item.env}'
  params: {
    location: location
    env: item.env
    addressPrefix: item.addressPrefix
    appName: item.appName
    shortLocation: shortLocation
    subnets: item.subnets
    hubVnetName: hub.outputs.vnetName
  }
}]
