<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000185

.DESCRIPTION
  Sets 'AllowOnlineID' to 0 to disable online identity use in PKU2U authentication.

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-13
  Last Modified:    2025-04-13
  STIG ID:          WN10-SO-000185
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    exit
}

# Define registry path and value
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\LSA\pku2u"
$regName = "AllowOnlineID"
$regValue = 0

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the required registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Output "Successfully applied WN10-SO-000185: Disabled use of online ID in PKU2U authentication."
}
catch {
    Write-Error "Failed to apply WN10-SO-000185: $_"
}
