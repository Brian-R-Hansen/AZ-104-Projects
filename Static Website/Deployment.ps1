# Ensure the environment variable is set
$subscriptionId = [System.Environment]::GetEnvironmentVariable("AZURE_SUBSCRIPTION_ID_1", "User")
if (-not $subscriptionId) {
    Write-Error "The AZURE_SUBSCRIPTION_ID environment variable is not set."
    exit
}

# Connect to Azure with the subscription ID
Connect-AzAccount -Subscription $subscriptionId

# Get the resource group name from the user
$resourceGroupName = Read-Host "Please eneter the resource group's name. Names can only include alphanumeric, underscore, parentheses, hyphen, period (except at the end), and unicode characters that match the allowed characters"

#Create the resource group
New-AzResourceGroup -Name $resourceGroupName -Location 'East US 2'

# Get storage account details from the user
$storageAccountName = Read-Host "Please enter the Storage Account name (must be unique)"

# Path to the Bicep file in the same directory as the PowerShell script
$scriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$bicepFile = Join-Path -Path $scriptPath -ChildPath "storageaccount.bicep"

# Deploy the Bicep file
New-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -TemplateFile $bicepFile `
    -storageAccountName $storageAccountName -skuName $storageSkuName