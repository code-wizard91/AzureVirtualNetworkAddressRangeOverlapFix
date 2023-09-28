# AzureVirtualNetworkAddressRangeOverlapFix
A Script library designed to address Azure Virtual Network (VNet) IP address range overlaps. Addressing a common pain point for many companies, this repository provides tools and best practices to diagnose and remediate overlapping VNet address spaces, ensuring smooth network integrations and minimizing service disruptions.

# Why is this an issue for many companies?

Overlapping IP address ranges in Azure VNets can lead to a variety of network challenges:

Service Disruption: If two VNets have overlapping IP ranges, resources in one VNet might not be accessible from the other. This can lead to application failures or disruptions if services expect seamless communication between VNets.

VPN & Peering Complications: Overlapping IP ranges can cause issues when setting up VPN connections or VNet peering, making it impossible to establish direct communication paths.

Network Confusion: For IT and network teams, overlapping addresses can create confusion, making it hard to determine which resources belong to which VNet, especially in larger or more complex environments.

Migration Challenges: Companies transitioning resources to Azure from on-premises or other cloud providers might inadvertently introduce address overlaps if they don't carefully plan their VNet address spaces.

Security Concerns: Incorrect routing due to overlaps could potentially expose services and resources to unintended networks, leading to potential security vulnerabilities.

Given these challenges, it's essential for companies to ensure their Azure VNets have unique IP address ranges to guarantee optimal networking operations. This repository aims to address these concerns by offering tools and methodologies to detect and fix such overlaps.

# Pre-Requisites 

- Powershell Installed
- az cli installed
- Install Azure PowerShell module - (Use Install-Module Az to install the official Azure PowerShell module on your local machine. Then use Connect-AzAccount to authenticate)

# Tutorial for fixing overlap and moving VM to new address range and subnet

- There are 2 versions of the script for moving vms, try both v1 and v2 and customise as needed.
- First run the script "getonlyoverlapaddressnames" to get all vnets with overlap issues, this will trawl all your subsriptions and compare address ranges to find issues. The script will create a CSV document with the matches found. Modify the script and add your own download location.
- Read the fix guide md also before proceeding to run the fix.
- Be careful and make sure you identify all the resources attached to the vnet address range and in its subnets that need to be moved to your new address range before removing overlapping address ranges otherwise you will lose network connectivity to those resources!

# Tutorial for moving Web app vnet integration to a new address range and subnet

- First run the script FindAllWebAppsWithVnetIntegrationEnabled.ps1 to find all apps with vnet integration enabled
- Analyse the results and identify the names of the vnets, keep them at hand.
- Use the MigrateAzureWebAppVnetIntegration.ps1 script to migrate your Web apps.
- You can further modify the script and add all your vnet names in one variable and loop over them, this will enable you to remove multiple vnet integrations in one go. You could go further and do the same loop but for attaching new vnet integrations to the web apps.
