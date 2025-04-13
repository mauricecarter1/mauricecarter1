<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000190

.DESCRIPTION
  Sets 'SupportedEncryptionTypes' to 0x7FFFFFF8 (2147483640) to restrict Kerberos to strong encryption types.

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-13
  Last Modified:    2025-04-13
  STIG ID:          WN10-SO-000190
#>

# Ensure script is run as Administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    exit
}

# Define registry path and value
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters"
$regName = "SupportedEncryptionTypes"
$regValue = 2147483640  # Decimal equivalent of 0x7FFFFFF8

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the required registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $regValue -Type DWord
    Write-Output "Successfully applied WN10-SO-000190: Set SupportedEncryptionTypes to 0x7FFFFFF8."
}
catch {
    Write-Error "Failed to apply WN10-SO-000190: $_"
}
