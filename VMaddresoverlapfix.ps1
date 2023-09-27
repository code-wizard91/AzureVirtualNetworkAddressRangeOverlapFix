az vm stop --resource-group rg01 --name VM01

# Resource group name 
rg="rg01"

# Existing VNet and VM details
vnetName="vnet01"
vmName="vm01" 

# New address space and subnet details
$addressPrefix="10.1.0.0/16" 
$subnetName="db"
$subnetPrefix="10.1.0.0/24"

# Get the VNet 
vnet=$(az network vnet show --resource-group $rg --name $vnetName --query id -o tsv)

# Add the address space
az network vnet update --ids $vnet --address-prefixes $addressPrefix

# Create the new subnet
az network vnet subnet create --vnet-name $vnetName --resource-group $rg --name $subnetName --address-prefixes $subnetPrefix

# Create the NIC
az network nic create --resource-group $rg --vnet-name $vnetName --subnet $subnetName -n nic1 

# Attach NIC to VM
az vm nic add --resource-group $rg --vm-name $vmName --nics nic1

#Detach old nic
az vm nic remove --resource-group rg01 --vm-name vm01 --nics oldnic

#Remove Old Subnet
az network vnet subnet delete --resource-group rg01 --vnet-name vnet01 --name oldsubnet

#Remove old address space 
### I would recommend doing this via the portal if this is a production vnet otherwise follow the below code replace "10.2.0.0/16" with the range you want to remove)

az network vnet show -g myResourceGroup -n myVnet --query addressSpace.addressPrefixes
addressPrefixes=($(az network vnet show -g myResourceGroup -n myVnet --query addressSpace.addressPrefixes -o tsv))
addressPrefixes[${!addressPrefixes[@]}]="10.2.0.0/16"
az network vnet update -g rg01 -n vnet01 --address-prefixes ${addressPrefixes[@]}
