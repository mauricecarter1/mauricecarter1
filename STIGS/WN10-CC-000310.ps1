<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000310

.DESCRIPTION
  Prevents users from changing installation options that affect system-wide settings 
  by setting the EnableUserControl registry value to 0, per DISA STIG WN10-CC-000310.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Policies\Microsoft\Windows\Installer\
  Value Name: EnableUserControl
  Value Type: REG_DWORD
  Required Value: 0

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-10
  Last Modified:    2025-04-10
  STIG ID:          WN10-CC-000310
#>

# Ensure the script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Define registry details
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer"
$regName = "EnableUserControl"
$regValue = 0

# Create the registry key if it does not exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
try {
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $regValue -Force | Out-Null
    Write-Output "STIG WN10-CC-000310 remediated successfully. EnableUserControl set to 0."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000310: $_"
}
