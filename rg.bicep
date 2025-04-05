targetScope = 'subscription'

param resourceGroupName string = 'bicep-rg-01'
param resourceGroupLocation string = 'eastus'

resource newRG 'Microsoft.Resources/resourceGroups@2018-05-01' = {
  name: resourceGroupName
  location: resourceGroupLocation

}
