# Source and destination VNet resource groups 
$sourceRG = "sourceRG"
$destRG = "destRG"

# Source and destination VNet names
$sourceVNet = "sourceVNet" 
$destVNet = "destVNet"

# Get the VM 
$vm = Get-AzVM -Name "vmName" -ResourceGroupName $sourceRG

# Get destination subnet ID
$destSubnetID = (Get-AzVirtualNetwork -Name $destVNet -ResourceGroupName $destRG).Subnets[0].Id

# Detach NIC from VM
$nic = Get-AzNetworkInterface -ResourceGroupName $sourceRG -Name $vm.NetworkProfile.NetworkInterfaces.Id.Split('/')[-1] 
$vm = Remove-AzVMNetworkInterface -VM $vm -NetworkInterfaceIDs $nic.Id

# Attach new NIC to VM
$nic = New-AzNetworkInterface -ResourceGroupName $destRG -Location $vm.Location -SubnetId $destSubnetID -Name $vm.Name 
$vm = Add-AzVMNetworkInterface -VM $vm -Id $nic.Id

# Update the VM
Update-AzVM -ResourceGroupName $destRG -VM $vm

# Delete old NIC
Remove-AzNetworkInterface -Name $vm.Name -ResourceGroupName $sourceRG
