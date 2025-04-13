<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000360

.DESCRIPTION
  Disables Digest authentication for WinRM client by setting:
  HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client\AllowDigest to 0

  This setting protects against sending credentials in a less secure manner.

.NOTES
  Author:           Maurice Carter
  LinkedIn:         linkedin.com/in/cmcarter38
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-13
  Last Modified:    2025-04-13
  STIG ID:          WN10-CC-000360
#>

# Registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client"
$ValueName = "AllowDigest"
$ExpectedValue = 0

# Create the registry key if it doesn't exist
if (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the value
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $ExpectedValue -Type DWord

# Confirm the change
$currentValue = Get-ItemPropertyValue -Path $RegPath -Name $ValueName
if ($currentValue -eq $ExpectedValue) {
    Write-Output "STIG WN10-CC-000360 remediated successfully. AllowDigest is set to 0."
} else {
    Write-Warning "Failed to remediate WN10-CC-000360. Current value: $currentValue"
}
