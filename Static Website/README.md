Azure Resource Group and Storage Account Deployment Script

This PowerShell script automates the process of creating an Azure Resource Group and a Storage Account, and then deploying an HTML file to a blob container within the Storage Account for public access.

Prerequisites

    Azure PowerShell installed
    Bicep CLI installed and configured
    Azure account with appropriate permissions to create resource groups and storage accounts
    Environment variable AZURE_SUBSCRIPTION_ID_1 set with your Azure subscription ID
    Bicep file (storageaccount.bicep) and HTML file (index.html) located in the same directory as this script

Usage

    Set the Environment Variable:
    Ensure the environment variable AZURE_SUBSCRIPTION_ID_1 is set with your Azure subscription ID.

    Run the Script:

    Execute the PowerShell script. The script will:
        Connect to Azure using the provided subscription ID.
        Prompt you to enter the name of the resource group.
        Create the resource group in the 'East US 2' region.
        Prompt you to enter the storage account name.
        Deploy the Bicep file to create the storage account.
        Upload the index.html file to the blob container web-app-container.

    Error Handling:

    If any step fails, the script will output an error message and exit. If the storage account creation fails, the script will also remove the created resource group.

Notes

    Ensure the names for the resource group and storage account comply with the naming conventions specified in the prompts.
    Adjust the region (East US 2) and container name (web-app-container) as needed.
