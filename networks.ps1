#[src ip]
$privateIp='ip 설정할것';

#[dst ip]
$localhostIp='127.0.0.1';

#[ports]
$ports=@(22,3000,3306,8080,8443);

Write-Output "portproxy reset";
iex "netsh interface portproxy reset";

iex "netsh interface portproxy show all";

Write-Output "portproxy set`n";

for( $i = 0; $i -lt $ports.length; $i++ ){
	$port = $ports[$i];

	Write-Output "portproxy ipv4 add $privateIp : $port to $localhostIp : $port";
	iex "netsh interface portproxy add v4tov4 listenport=$port listenaddress=$privateIp connectport=$port connectaddress=$localhostIp";
}

iex "netsh interface portproxy show all";

#[windows firewall]
$ports_a = $ports -join ",";
$firewallName="WSL 2 Firewall Unlock";

Write-Output "Remove Firewall Exception Rules : $firewallName";
iex "Remove-NetFireWallRule -DisplayName '$firewallName' ";

Write-Output "Adding Exception Rules for inbound and outbound Rules : $firewallName";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Outbound -LocalPort $ports_a -Action Allow -Protocol TCP";
iex "New-NetFireWallRule -DisplayName '$firewallName' -Direction Inbound -LocalPort $ports_a -Action Allow -Protocol TCP";
