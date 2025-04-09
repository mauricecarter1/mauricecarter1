<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000030

.DESCRIPTION
  Configures the registry to ensure that legacy audit policies do not override
  audit policy settings configured via Group Policy.

  This aligns with DISA STIG requirement WN10-SO-000030 for Windows 10 systems.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SYSTEM\CurrentControlSet\Control\Lsa\
  Value Name: SCENoApplyLegacyAuditPolicy
  Value Type: REG_DWORD
  Required Value: 1

.NOTES
    Author          : Maurice Carter
    LinkedIn        : linkedin.com/in/cmcarter38/
    GitHub          : github.com/mauricecarter1
    Date Created    : 2025-04-08
    Last Modified   : 2025-04-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000030
 
#>

# Ensure the script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator."
    Exit
}

# Set the registry key to enforce advanced audit policy
try {
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa" `
                     -Name "SCENoApplyLegacyAuditPolicy" `
                     -Value 1 `
                     -Type DWord

    Write-Output "STIG WN10-SO-000030 remediated successfully. Legacy audit policies are now disabled."
}
catch {
    Write-Error "Failed to apply STIG WN10-SO-000030: $_"
}

