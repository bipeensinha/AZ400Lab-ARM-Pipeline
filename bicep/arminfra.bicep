// check quota
param location string = 'westus2'
param storageAccountName string = 'bipeenst987sde'  // Ensure uniqueness
param blobContainerName string = 'armdata'






// 📦 Storage Account
resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
    tags: {
    Environment: 'Production'
    Owner: 'Bipeen'
    Project: 'Azure DevOps Deployment'
  }
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


output storageAccount string = storageAccount.name
output blobContainer string = blobContainer.name
