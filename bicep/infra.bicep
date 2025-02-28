param location string = 'eastus'
param appServicePlanName string = 'myAppServicePlan'
param webAppName string = 'bipeenapp8765'
param storageAccountName string = 'bipeenst987'  // Change to unique name
param blobContainerName string = 'myblobcontainer'
param skuName string = 'S1'  // Standard pricing tier

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: 'Standard'
  }
  properties: {
    perSiteScaling: false
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v4.8'  // ASP.NET 4.8 Support
    }
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = {
  parent: storageAccount
  name: blobContainerName
}

output webAppUrl string = 'https://${webAppName}.azurewebsites.net'
output storageAccount string = storageAccount.name
output blobContainer string = blobContainer.name
