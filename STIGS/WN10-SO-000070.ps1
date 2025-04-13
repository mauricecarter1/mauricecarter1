<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000070

.DESCRIPTION
  Sets 'InactivityTimeoutSecs' to 900 seconds (or less) to enforce automatic session timeout.
  This protects against unauthorized access when a user leaves a system unattended.

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-13
  Last Modified:    2025-04-13
  STIG ID:          WN10-SO-000070
#>

# Ensure the script is run with administrative privileges
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    exit
}

# Define the registry path, name, and desired value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "InactivityTimeoutSecs"
$regValue = 900  # Set to 15 minutes (900 seconds)

# Create registry key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the setting
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Output "Successfully applied WN10-SO-000070: InactivityTimeoutSecs set to $regValue seconds."
}
catch {
    Write-Error "Failed to apply WN10-SO-000070: $_"
}
