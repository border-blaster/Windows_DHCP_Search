$MAC=$args[0]
$dhcpservername = "PUTYOURSERVERNAMEHERE"

if ($MAC -eq $null) { $MAC = read-host "MAC address (xx-xx-xx-xx-xx-xx)" }

foreach ($scope in Get-DhcpServerv4Scope -ComputerName $dhcpservername){Get-DhcpServerv4Lease -ComputerName $dhcpservername -AllLeases -ScopeId $scope.ScopeId | Where-Object {$_.clientid -match $MAC} | fl}
