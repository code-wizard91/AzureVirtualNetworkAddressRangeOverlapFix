# Variables
resourceGroupName="rg01"
appName="webapp01"
vnetName="vnet01"
newSubnetName="subnet01"

# Login to Azure (this will prompt you to open a page and enter a code if not already logged in)
az login

# Ensure that the new subnet is delegated to Microsoft.Web/serverFarms
az network vnet subnet update --name $newSubnetName --vnet-name $vnetName --resource-group $resourceGroupName --delegations Microsoft.Web/serverFarms

# Remove existing VNet Integration from the Web App
az webapp vnet-integration remove --name $appName --resource-group $resourceGroupName --vnet $vnetName

# Add new VNet Integration to the Web App using the new subnet
az webapp vnet-integration add --name $appName --resource-group $resourceGroupName --vnet $vnetName --subnet $newSubnetName

