<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Maurice Carter
    LinkedIn        : linkedin.com/in/cmcarter38/
    GitHub          : github.com/mauricecarter1
    Date Created    : 2025-04-07
    Last Modified   : 2025-04-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path and the value to set
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"
$valueName = "MaxSize"
$valueData = 0x8000  # 0x8000 in hexadecimal = 32,768 in decimal (32 MB)

# Check if the registry path exists; create it if it doesn't
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the MaxSize DWORD value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# Confirm the change
Write-Output "Registry value '$valueName' set to $valueData (hex: 0x{0:X}) at $registryPath" -f $valueData
