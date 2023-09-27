# Variables
resourceGroupName="YourResourceGroupName"
appName="YourWebAppName"
vnetName="YourVnetName"
newSubnetName="YourNewSubnetName"

# Login to Azure (this will prompt you to open a page and enter a code if not already logged in)
az login

# Ensure that the new subnet is delegated to Microsoft.Web/serverFarms
az network vnet subnet update --name $newSubnetName --vnet-name $vnetName --resource-group $resourceGroupName --delegations Microsoft.Web/serverFarms

# Remove existing VNet Integration from the Web App
az webapp vnet-integration remove --name $appName --resource-group $resourceGroupName --vnet $vnetName

# Wait for a few minutes. Removing VNet integration might take some time.

# Add new VNet Integration to the Web App using the new subnet
az webapp vnet-integration add --name $appName --resource-group $resourceGroupName --vnet $vnetName --subnet $newSubnetName

