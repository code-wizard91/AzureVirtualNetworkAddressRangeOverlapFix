Analyse the network very carefully. Looking at any services that are deployed into the VNET. this could be private endpoints, Web apps, Function apps.
Also check the vnet connected devices (Example below is moving a vm which is inside a overlapping address range, We will be creating a new range and subnet and moving the VM over) 
STOP VM
Add new address space changes to virtual network 'exampleVnet' and any subnets that you need
Create and Attach a new network interface 'example-nic02' to virtual machine 'vm01'. This is done via VM network settings
Detach network interface 'nic01' from virtual machine 'vm01'.
Delete all resources in the old subnet which in this case is the old nic
Delete the subnet
Add nsg back into new nic
