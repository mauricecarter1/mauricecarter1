<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000052

.DESCRIPTION
  Restricts allowed ECC (Elliptic Curve Cryptography) curves to only NistP384 and NistP256
  for SSL/TLS configuration to meet DISA STIG compliance.

  This aligns with DISA STIG requirement WN10-CC-000052.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002\
  Value Name: EccCurves
  Value Type: REG_MULTI_SZ
  Required Value: NistP384 NistP256

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-09
  Last Modified:    2025-04-09
  STIG ID:          WN10-CC-000052
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Define the approved ECC curves as a string array
[string[]]$approvedCurves = @("NistP384", "NistP256")

# Registry path
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Cryptography\Configuration\SSL\00010002"

# Create the key if it doesn't exist
If (-Not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply the approved ECC curves
try {
    New-ItemProperty -Path $regPath -Name "EccCurves" -PropertyType MultiString -Value $approvedCurves -Force | Out-Null
    Write-Output "STIG WN10-CC-000052 remediated successfully. ECC curves set to NistP384 and NistP256."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000052: $_"
}
