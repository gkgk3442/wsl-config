#PowerShell.exe -ExecutionPolicy Bypass -File .\wsl-networks.ps1
#explorer.exe .
#$remoteport = wsl hostname -I
#$remoteport = wsl -d Ubuntu ifconfig docker0 `| grep "inet "

$remoteport = wsl -d Ubuntu ifconfig eth0 `| grep "inet "
$found = $remoteport -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}';

if( $found ){
  $remoteport = $matches[0];
  Write-Output "Ubuntu eth0 inet : $remoteport";
} else{
  echo "The Script Exited, the ip address of WSL 2 cannot be found";
  exit;
}

#[Static ip]
$ipv4Address=@('0.0.0.0','127.0.0.1');
$ipv6Address=@('::0','::1');

#[Ports]
$ports=@(22,3306);

$ports_a = $ports -join ",";

#[Firewall name]
$firewallName="WSL 2 Firewall Unlock";

Write-Output "Remove Firewall Exception Rules : $firewallName";
iex "Remove-NetFireWallRule -DisplayName '$firewallName' ";

Write-Output "Adding Exception Rules for inbound and outbound Rules : $firewallName";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";

Write-Output "portproxy reset";
iex "netsh interface portproxy reset";
	
for( $i = 0; $i -lt $ports.length; $i++ ){
	$port = $ports[$i];

	for( $j = 0; $j -lt $ipv4Address.length; $j++ ){
		$addr = $ipv4Address[$j];		
		#		iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
		
		Write-Output "portproxy ipv4 to ipv4 add $addr : $port";
		iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
	}
	
	for( $j = 0; $j -lt $ipv6Address.length; $j++ ){
		$addr = $ipv6Address[$j];		
		#		iex "netsh interface portproxy delete v4tov4 listenport=$port listenaddress=$addr";
		
		Write-Output "portproxy ipv6 to ipv4 add $addr : $port";
		iex "netsh interface portproxy add v6tov4 listenport=$port listenaddress=$addr connectport=$port connectaddress=$remoteport";
	}
}
