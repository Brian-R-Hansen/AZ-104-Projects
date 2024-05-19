// Define the parameters for the Storage account and Blob container
param storageName string

// Create a Storage account resource
resource storageAcct 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageName
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

// Create a Blob container resource within the Storage account
resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '$storageAcct/default/webappContainer'
  properties: {
    publicAccess: 'Blob'
  }
}
