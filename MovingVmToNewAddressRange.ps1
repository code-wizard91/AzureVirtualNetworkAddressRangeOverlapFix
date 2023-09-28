# Variables
resourceGroupName="YourResourceGroupName"
vnetName="YourVnetName"
newAddressPrefix="10.1.0.0/24"
newSubnetName="db"
newSubnetAddressPrefix="10.1.0.0/24"
vmName="YourVMName"
oldSubnetName="oldsubnet"

# Login to Azure (this might prompt you to open a page and enter a code if not already logged in)
az login

# Add a new address range to the existing VNet
az network vnet update --name $vnetName --resource-group $resourceGroupName --address-prefixes $newAddressPrefix

# Create a new subnet called 'db' within the new address range
az network vnet subnet create --name $newSubnetName --vnet-name $vnetName --resource-group $resourceGroupName --address-prefix $newSubnetAddressPrefix

# Deallocate the VM
az vm deallocate --name $vmName --resource-group $resourceGroupName

# Retrieve the NIC associated with the VM
nicName=$(az vm show --name $vmName --resource-group $resourceGroupName --query "networkProfile.networkInterfaces[0].id" -o tsv | awk -F "/" '{print $9}')

# Get the name of the primary IP configuration for the NIC
ipConfigName=$(az network nic show --name $nicName --resource-group $resourceGroupName --query "ipConfigurations[0].name" -o tsv)

# Update the IP configuration to move it to the new subnet
az network nic ip-config update --name $ipConfigName --nic-name $nicName --resource-group $resourceGroupName --subnet $newSubnetName --vnet-name $vnetName

# Start the VM after moving it to the new subnet
az vm start --name $vmName --resource-group $resourceGroupName
