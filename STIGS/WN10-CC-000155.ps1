<#
.SYNOPSIS
  Remediates STIG WN10-CC-000155

.DESCRIPTION
  Sets the 'fAllowToGetHelp' registry value to 0 to disable Remote Assistance requests.

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-12
  Last Modified:    2025-04-12
  STIG ID:          WN10-CC-000155
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    exit
}

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$regName = "fAllowToGetHelp"
$regValue = 0

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the required registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Output "Successfully applied WN10-CC-000155: Disabled Remote Assistance request feature."
}
catch {
    Write-Error "Failed to apply WN10-CC-000155: $_"
}
