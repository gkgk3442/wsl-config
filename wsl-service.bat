"C:\Windows\System32\bash.exe" -c "sudo service ssh start"
"C:\Windows\System32\bash.exe" -c "sudo service cron start"
"C:\Windows\System32\bash.exe" -c "sudo service docker start"

PowerShell.exe -ExecutionPolicy Bypass -File .\wsl-networks.ps1
