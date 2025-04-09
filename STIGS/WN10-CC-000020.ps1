<#
.SYNOPSIS
  Remediates STIG ID: WN10-CC-000020

.DESCRIPTION
  Disables IP source routing for IPv6 to prevent network-based attacks
  that exploit source routing behavior.

  This aligns with DISA STIG requirement WN10-CC-000020.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters\
  Value Name: DisableIpSourceRouting
  Value Type: REG_DWORD
  Required Value: 2

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-08
  Last Modified:    2025-04-08
  STIG ID:          WN10-CC-000020
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Set the registry value to disable IP source routing for IPv6
try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters" `
                     -Name "DisableIpSourceRouting" `
                     -Value 2 `
                     -Type DWord

    Write-Output "STIG WN10-CC-000020 remediated successfully. IP source routing is now disabled for IPv6."
}
catch {
    Write-Error "Failed to apply STIG WN10-CC-000020: $_"
}
