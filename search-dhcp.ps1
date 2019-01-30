### Windows DHCP Search
### github.com/border-blaster
### v2019-01-30
$OrginalMAC=$args[0]

### Enter in your DHCP server name:
$dhcpservername = "SERVERNAME"

### If the MAC was in an arugutment, get the MAC.
if ($OrginalMAC -eq $null) { $OrginalMAC = read-host "MAC address" }

### Clean up the MAC, unless it is a mess.
# Lifted from: https://gist.github.com/border-blaster/9cc0ed0fa5967fafc301bb78d18a467e
$CleanMAC = $OrginalMAC -replace '[-.:]',''
if ($CleanMAC.length -ne 12) { write-host "MAC address is made of 12 alphanumeric characters"
exit}

#Dashes X 2
$LocationCount = 2
$AddCount = 3
$WhatToInsert = "-"
$CountLimit = "14"
$InputMAC = $CleanMAC

Do {
	$InputMAC = $InputMAC.Insert($LocationCount,$WhatToInsert)
	$LocationCount = $LocationCount + $AddCount
	} until ($LocationCount -gt $CountLimit)
$InputMAC


foreach ($scope in Get-DhcpServerv4Scope -ComputerName $dhcpservername){Get-DhcpServerv4Lease -ComputerName $dhcpservername -AllLeases -ScopeId $scope.ScopeId | Where-Object {$_.clientid -match $InputMAC} | fl}
