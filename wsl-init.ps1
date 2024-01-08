#PowerShell.exe -ExecutionPolicy Bypass -File .\wsl-networks.ps1
#explorer.exe .

#[Ports]
$ports=@(22,80,443,3000,3306,6379,8080,8443);

#[Static ip]
$ipv4Address=@('0.0.0.0');
$ipv6Address=@('::');

echo "=================================================================================";
echo "wsl run";
echo "=================================================================================";
powershell.exe -Command "start-process wsl.exe -WindowStyle Hidden"

echo "=================================================================================";
echo "windows firewall";
echo "=================================================================================";

#[Firewall name]
$firewallName="WSL 2 Firewall Unlock";
$ports_a = $ports -join ",";

echo "Remove Firewall Exception Rules : $firewallName";
iex "Remove-NetFireWallRule -DisplayName '$firewallName' ";

echo "Adding Exception Rules for inbound and outbound Rules : $firewallName : $ports_a";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";

echo "=================================================================================";
echo "wsl port forwarding";
echo "=================================================================================";

#$wslAddress = wsl hostname -I
#$wslAddress = wsl -d Ubuntu ifconfig docker0 `| grep "inet "

$wslAddress = wsl -d Ubuntu ifconfig eth0 `| grep "inet "
$found = $wslAddress -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
  $wslAddress = $matches[0];
  Write-Output "Ubuntu eth0 inet : $wslAddress";
} else{
  echo "The Script Exited, the ip address of WSL 2 cannot be found";
  sleep 30;
  exit;
}

echo "port proxy reset";
iex "netsh interface portproxy reset";
	
for( $i = 0; $i -lt $ports.length; $i++ ){
	$port = $ports[$i];

	for( $j = 0; $j -lt $ipv4Address.length; $j++ ){
		$addr = $ipv4Address[$j];
		
		Write-Output "portproxy ipv4 add $addr : $port to $wslAddress : $port";
		iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$wslAddress";
	}
	
	for( $j = 0; $j -lt $ipv6Address.length; $j++ ){
		$addr = $ipv6Address[$j];

		Write-Output "portproxy ipv6 add $addr : $port to $wslAddress : $port";
		iex "netsh interface portproxy add v6tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$wslAddress";
	}
}

iex "netsh interface portproxy show all";
