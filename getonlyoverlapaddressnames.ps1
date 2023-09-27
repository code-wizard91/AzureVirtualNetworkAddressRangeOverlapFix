$subscriptions = Get-AzSubscription

# Create empty list 
$results = @()

# Loop through subscriptions
foreach ($sub in $subscriptions) {

  # Set subscription 
  Select-AzSubscription -SubscriptionId $sub.Id

  # Get VNets
  $vnets = Get-AzVirtualNetwork

  # Loop through VNets
  foreach ($vnet in $vnets) {

    # Get address space
    $space = $vnet.AddressSpace.AddressPrefixes

    # Check for overlaps
    $overlap = $results.Where({$_.AddressSpace -in $space}) | Select-Object -ExpandProperty VNet

    # Add to results
    $result = [PSCustomObject]@{
      Subscription = $sub.Name
      VNet = $vnet.Name  
      AddressSpace = $space -join "," 
      OverlappingVnets = $overlap -join ", "
    }

    $results += $result

  }

}

# Export CSV
$results | Export-Csv -Path "C:\Users\mahboob.ali\Documents\simplifiedoverlap.csv" -NoTypeInformation