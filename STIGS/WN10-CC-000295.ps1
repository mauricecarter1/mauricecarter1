<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000295

.DESCRIPTION
  Disables automatic download of enclosures in RSS feeds by setting the 
  DisableEnclosureDownload registry value to 1, in compliance with 
  DISA STIG WN10-CC-000295.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds\
  Value Name: DisableEnclosureDownload
  Value Type: REG_DWORD
  Required Value: 1

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-10
  Last Modified:    2025-04-10
  STIG ID:          WN10-CC-000295
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Internet Explorer\Feeds"
$regName = "DisableEnclosureDownload"
$regValue = 1

# Create the registry key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
try {
    New-ItemProperty -Path $regPath -Name $regName -PropertyType DWord -Value $regValue -Force | Out-Null
    Write-Output "STIG WN10-CC-000295 remediated successfully. DisableEnclosureDownload set to 1."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000295: $_"
}
