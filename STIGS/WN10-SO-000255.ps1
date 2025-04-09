<#
.SYNOPSIS
  Remediates STIG ID: WN10-SO-000255

.DESCRIPTION
  Configures the User Account Control (UAC) settings to ensure the correct prompt behavior
  for elevated processes, disabling the UAC consent prompt for standard users.

  This aligns with DISA STIG requirement WN10-SO-000255.

  Registry Hive: HKEY_LOCAL_MACHINE
  Registry Path: \SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System\
  Value Name: ConsentPromptBehaviorUser
  Value Type: REG_DWORD
  Required Value: 0

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-09
  Last Modified:    2025-04-09
  STIG ID:          WN10-SO-000255
#>

# Ensure script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# Set the registry value to configure UAC Consent Prompt Behavior
try {
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" `
                     -Name "ConsentPromptBehaviorUser" `
                     -Value 0 `
                     -Type DWord

    Write-Output "STIG WN10-SO-000255 remediated successfully. Consent prompt behavior is now configured correctly."
}
catch {
    Write-Error "Failed to apply STIG WN10-SO-000255: $_"
}
