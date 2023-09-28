# Login to Azure (this might prompt you to open a page and enter a code if not already logged in)
az login

# CSV file path
csvFile="webapps_with_vnet.csv"

# Initialize CSV with headers
echo "ResourceGroup,WebAppName,VNet,Subnet" > $csvFile

# Loop through all resource groups in your subscription
for rg in $(az group list --query "[].name" -o tsv); do
    # Loop through all web apps in the resource group
    for app in $(az webapp list --resource-group $rg --query "[].name" -o tsv); do
        # Check if the web app has VNet integration
        vnetIntegration=$(az webapp vnet-integration list --name $app --resource-group $rg)
        
        if [ $(echo $vnetIntegration | jq '. | length') -gt 0 ]; then
            vnetName=$(echo $vnetIntegration | jq '.[0].vnetResourceID' -r | awk -F'/' '{print $(NF-1)}')
            subnetName=$(echo $vnetIntegration | jq '.[0].subnetName' -r)
            echo "$rg,$app,$vnetName,$subnetName" >> $csvFile
        fi
    done
done

echo "Script complete. Check the file $csvFile for the list of web apps with VNet integration."
