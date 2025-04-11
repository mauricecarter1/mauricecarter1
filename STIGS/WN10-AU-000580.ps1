<#
.SYNOPSIS
  Remediates STIGs:
    - WN10-SO-000030 (Force audit policy subcategory settings)
    - WN10-AU-000580 (Audit MPSSVC Rule-Level Policy Change - Failure)

.DESCRIPTION
  This script ensures audit subcategory policy settings override category settings (WN10-SO-000030),
  and sets auditing for MPSSVC Rule-Level Policy Change failures (WN10-AU-000580), using auditpol.

.NOTES
  Author:           Maurice Carter 
  LinkedIn:         linkedin.com/in/cmcarter38/
  GitHub:           github.com/mauricecarter1
  Date Created:     2025-04-11
  Last Modified:    2025-04-11
  STIG ID:          WN10-SO-000030, WN10-AU-000580
#>

# Ensure the script is run as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
        [Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "Administrator privileges required. Please run this script as Administrator."
    Exit
}

# ========== Step 1: Apply WN10-SO-000030 ==========

$lsaPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$lsaName = "SCENoApplyLegacyAuditPolicy"
$lsaValue = 1

Write-Output "`nChecking audit policy subcategory enforcement (WN10-SO-000030)..."

# Create the registry path if needed
If (-Not (Test-Path $lsaPath)) {
    New-Item -Path $lsaPath -Force | Out-Null
}

# Set the value only if it isn't already set
$currentValue = Get-ItemProperty -Path $lsaPath -Name $lsaName -ErrorAction SilentlyContinue
If ($currentValue.$lsaName -ne $lsaValue) {
    try {
        Set-ItemProperty -Path $lsaPath -Name $lsaName -Value $lsaValue -Type DWord
        Write-Output "Applied WN10-SO-000030: Enabled SCENoApplyLegacyAuditPolicy (subcategories will override categories)."
    }
    catch {
        Write-Error "Failed to apply WN10-SO-000030: $_"
    }
} else {
    Write-Output "WN10-SO-000030 already set correctly."
}

# ========== Step 2: Apply WN10-AU-000500 ==========

Write-Output "`nConfiguring audit setting for MPSSVC Rule-Level Policy Change (WN10-AU-000500)..."

try {
    auditpol /set /subcategory:"MPSSVC Rule-Level Policy Change" /failure:enable
    Write-Output "Applied WN10-AU-000500: 'Failure' auditing enabled for MPSSVC Rule-Level Policy Change."
}
catch {
    Write-Error "Failed to apply WN10-AU-000500: $_"
}
