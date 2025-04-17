# Brute-Force-Simulation.ps1
# Simulates failed login attempts using ValidateCredentials() to trigger Windows Security Event ID 4625
# Intended for brute-force detection labs in Windows environments (e.g., Defender for Endpoint, Microsoft Sentinel)

<#
.NOTES
    Author: Maurice Carter
    LinkedIn: https://linkedin.com/in/cmcarter38
    GitHub: https://github.com/mauricecarter1
    Date Created: 2025-04-13
    Last Modified: 2025-04-13
  
#>

Add-Type -AssemblyName System.DirectoryServices.AccountManagement

# Replace "2Phishing-Lab-MC" with the name of a valid local user account on your lab machine 
$TargetUsername = "2Phishing-Lab-MC"

$PasswordList = @("Password1", "123456", "admin", "letmein", "qwerty")

foreach ($password in $PasswordList) {
    Write-Host "Trying password: $password"

    $context = New-Object System.DirectoryServices.AccountManagement.PrincipalContext('Machine', $env:COMPUTERNAME)
    $result = $context.ValidateCredentials($TargetUsername, $password)

    if ($result) {
        Write-Host "✅ Successful login with password: $password"
    } else {
        Write-Host "❌ Failed login recorded."
    }

    Start-Sleep -Seconds 2
}

