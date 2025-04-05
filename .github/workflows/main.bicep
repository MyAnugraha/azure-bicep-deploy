targetScope = 'resourceGroup'

param vmName string = 'myVM'
@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param adminPassword string
param adminUserName string = 'Hellovmbhai'


resource vnet 'Microsoft.Network/virtualNetworks@2017-06-01' = {
  name: 'myVNet'
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'mySubnet'
        properties: {
          addressPrefix: '10.0.0.0/24'
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2017-06-01' = {
  name: 'myNSG'
  location: 'eastus'
  properties: {}
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2017-06-01' = {
  name: '${vmName}-publicIP'
  location: 'eastus'
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2017-06-01' = {
  name: '${vmName}-nic'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: vnet.properties.subnets[0].id // Correct reference to subnet.id
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id // Ensure public IP is defined before NIC
          }
        }
      }
    ]
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2017-12-01' = {
  name: vmName
  location: 'eastus'
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B1s'
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUserName
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'Canonical'
        offer: 'UbuntuServer'
        sku: '18.04-LTS'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
  }
}
