// Define the parameters for the Storage account and Blob container
param storageAccountName string

// Create a Storage account resource
resource storageAcct 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: 'East US 2'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    minimumTlsVersion: 'TLS1_2'
    publicNetworkAccess: 'Enabled'
    supportsHttpsTrafficOnly: true
    routingPreference: {
      routingChoice: 'InternetRouting'
    }
  }
}

// Define the blob service as a resource
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  parent: storageAcct
  name: 'default'
  properties: {}
}

// Create a Blob container resource within the Blob service
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'web-app-container'
  properties: {
    publicAccess: 'Blob'
  }
}
