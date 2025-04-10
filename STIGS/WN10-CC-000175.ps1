<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000175

.DESCRIPTION
  Disables the Windows Application Compatibility Program Inventory feature
  by setting the registry value DisableInventory to 1, in accordance with 
  DISA STIG WN10-CC-000175.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Policies\Microsoft\Windows\AppCompat\
  Value Name: DisableInventory
  Value Type: REG_DWORD
  Required Value: 1

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-10
  Last Modified:    2025-04-10
  STIG ID:          WN10-CC-000175
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Define the registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppCompat"
$regName = "DisableInventory"
$regValue = 1

# Create the registry key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
try {
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $regValue -Force | Out-Null
    Write-Output "STIG WN10-CC-000175 remediated successfully. DisableInventory set to 1."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000175: $_"
}
