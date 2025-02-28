param location string = 'westeurope'
param appServicePlanName string = 'myAppServicePlan'
param webAppName string = 'bipeenapp8765'
param storageAccountName string = 'bipeenst987'  // Ensure uniqueness
param blobContainerName string = 'myblobcontainer'
param skuName string = 'B1'  // Updated to B1 since F1 was causing issues

// 🚀 App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: 'Basic'
  }
  properties: {
    perSiteScaling: false
  }
}

// 🌐 Web App with .NET 4.8 and Tags
resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      netFrameworkVersion: 'v4.8'  // ASP.NET 4.8 Support
    }
  }
  tags: {
    Environment: 'Production'
    Owner: 'Bipeen'
    Project: 'Azure DevOps Deployment'
  }
}

// 📦 Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

// 📌 Blob Service inside Storage Account
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2021-02-01' = {
  name: 'default'  // Default name for blob service
  parent: storageAccount
}

// 📌 Blob Container
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-02-01' = {
  name: blobContainerName
  parent: blobService  // 👈 Correctly set the parent
}

output webAppUrl string = 'https://${webAppName}.azurewebsites.net'
output storageAccount string = storageAccount.name
output blobContainer string = blobContainer.name
