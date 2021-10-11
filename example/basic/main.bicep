module naming 'naming/naming.bicep' = {
  name: 'naming'
  params: {
    app: 'app1'
    env: 'prd'
    loc: 'uks'
  }
}

module storage 'storage.bicep' = {
  name: 'storage'
  params: {
    location: 'uksouth'
    name: naming.outputs.storage
  }
}

module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: 'uksouth'
    name: naming.outputs.vnet
  }
}

module vm 'vm.bicep' = {
  name: 'vm'
  params: {
    adminPassword: 'P@55w0rd!'
    adminUsername: 'tom'
    location: 'uksouth'
    name: '${naming.outputs.vm}01'
    subnetId: vnet.outputs.subnetIds[0]
  }
}
