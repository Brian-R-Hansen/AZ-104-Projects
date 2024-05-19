try {
    # Assign the environment variable
    $subscriptionId = [System.Environment]::GetEnvironmentVariable("AZURE_SUBSCRIPTION_ID_1", "User")
    # Connect to Azure with the subscription ID
    Connect-AzAccount -Subscription $subscriptionId
}
catch {
    Write-Output "An error occurred while connecting to Azure: $_"
    Exit 1
}

# Get the resource group name from the user
$resourceGroupName = Read-Host -Prompt @"
Please enter the resource group's name. 
Names can only include:
- Alphanumeric characters
- Underscores (_)
- Parentheses ()
- Hyphens (-)
- Periods (except at the end)
- Unicode characters that match the allowed characters
"@
Write-Output "You entered: $resourceGroupName"

try {
    #Create the resource group
    New-AzResourceGroup -Name $resourceGroupName -Location 'East US 2'
}
catch {
    Write-Output "An error occurred while creating the resource group: $_"
    Exit 1
}

# Prompt the user for the storage account name
$storageAccountName = Read-Host -Prompt @"
Please enter the Storage Account name. 
The name must:
- Be unique across all existing storage account names in Azure
- Be 3 to 24 characters long
- Contain only lowercase letters and numbers
"@

# Path to the Bicep file in the same directory as the PowerShell script
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$bicepFile = Join-Path -Path $scriptPath -ChildPath "storageaccount.bicep"

try {
    # Deploy the Bicep file
    New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $bicepFile `
    -storageAccountName $storageAccountName 
    
}
catch {
    Write-Output "An error occurred while creating the storage account or container: $_"
    Remove-AzResourceGroup -Name $resourceGroupName -Force
    Exit 1
}

try {
    #Path to the html file in the same directory as the PowerShell script
    $htmlFile = Join-Path -Path $scriptPath -ChildPath "index.html"
    # Get the storage account context
    $storageAccount = Get-AzStorageAccount -ResourceGroupName $resourceGroupName -Name $storageAccountName
    $ctx = $storageAccount.Context
    # Upload the file to the blob container
    Set-AzStorageBlobContent -File $htmlFile -Container 'web-app-container' -Blob "index.html" -Context $ctx
    
}
catch {
    Write-Output "An error occurred while uploading the index.html document $_"
}