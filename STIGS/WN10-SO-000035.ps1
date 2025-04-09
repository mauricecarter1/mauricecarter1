<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000035

.DESCRIPTION
  Ensures that Windows 10 systems require signing and sealing of secure channel traffic,
  which prevents unauthorized access and tampering.

  This aligns with DISA STIG requirement WN10-SO-000035.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SYSTEM\CurrentControlSet\Services\Netlogon\Parameters\
  Value Name: RequireSignOrSeal
  Value Type: REG_DWORD
  Required Value: 1

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-08
  Last Modified:    2025-04-08
  STIG ID:          WN10-SO-000035
  
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Set the registry value to enforce signing/sealing secure channel traffic
try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Netlogon\Parameters" `
                     -Name "RequireSignOrSeal" `
                     -Value 1 `
                     -Type DWord

    Write-Output "STIG WN10-SO-000035 remediated successfully. Secure channel signing/sealing is now required."
}
catch {
    Write-Error "Failed to apply STIG WN10-SO-000035: $_"
}
