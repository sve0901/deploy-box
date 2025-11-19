# Wait for 10 seconds
Start-Sleep -Seconds 10

# Restart the service named "CagService"
Restart-Service -Name "CagService" -Force

# Output a message
Write-Output "CagService has been restarted and settings updated."
