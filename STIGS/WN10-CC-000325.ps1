<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000325

.DESCRIPTION
  Disables automatic sign-on after a system restart by setting the 
  DisableAutomaticRestartSignOn registry value to 1, in compliance 
  with DISA STIG WN10-CC-000325.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\
  Value Name: DisableAutomaticRestartSignOn
  Value Type: REG_DWORD
  Required Value: 1

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-10
  Last Modified:    2025-04-10
  STIG ID:          WN10-CC-000325
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Define registry details
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "DisableAutomaticRestartSignOn"
$regValue = 1

# Create the registry key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
try {
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $regValue -Force | Out-Null
    Write-Output "STIG WN10-CC-000325 remediated successfully. DisableAutomaticRestartSignOn set to 1."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000325: $_"
}
