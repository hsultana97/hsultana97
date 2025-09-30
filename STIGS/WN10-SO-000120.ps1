<#
.SYNOPSIS
    This PowerShell script ensures that the Windows SMB server must be configured to always perform SMB packet signing.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-30
    Last Modified   : 2025-09-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000120 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000120.ps1 
#>

# Description: Enforces SMB server packet signing

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"
$valueName = "RequireSecuritySignature"
$desiredValue = 1

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path not found. Creating it..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
try {
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "Successfully configured SMB server to require packet signing." -ForegroundColor Green
}
catch {
    Write-Error "Failed to apply SMB server packet signing setting: $_"
}
