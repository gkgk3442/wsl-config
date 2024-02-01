$firewallName="WSL 2 Firewall Unlock";
echo "Remove Firewall Exception Rules : $firewallName";
iex "Remove-NetFireWallRule -DisplayName '$firewallName' ";

echo "port proxy reset";
iex "netsh interface portproxy reset";
