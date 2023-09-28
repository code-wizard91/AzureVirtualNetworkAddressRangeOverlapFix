#!/bin/bash

# Variables
resourceGroupName="rg01"
vnetName="vnet01"
newAddressPrefix="10.1.0.0/24"
newSubnetName="subnet01"
newSubnetAddressPrefix="10.1.0.0/24"

# Function to check the last command's result
check_exit_status() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Login to Azure
az login
check_exit_status "Failed to login to Azure."

# Check if the VNet exists
az network vnet show --name $vnetName --resource-group $resourceGroupName > /dev/null 2>&1
check_exit_status "The specified VNet does not exist."

# Add the new address range to the existing VNet
az network vnet update --name $vnetName --resource-group $resourceGroupName --address-prefixes $newAddressPrefix
check_exit_status "Failed to add the address range to the VNet."

# Create the new subnet within the new address range
az network vnet subnet create --name $newSubnetName --vnet-name $vnetName --resource-group $resourceGroupName --address-prefix $newSubnetAddressPrefix
check_exit_status "Failed to create the new subnet."

echo "Address range and subnet created successfully!"
