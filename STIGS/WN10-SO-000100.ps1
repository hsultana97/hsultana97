<#
.SYNOPSIS
    This PowerShell script ensures that the Windows SMB client must be configured to always perform SMB packet signing.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-30
    Last Modified   : 2025-09-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000100 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000100.ps1 
#>

# Description: Ensures the SMB client requires packet signing

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"
$valueName = "RequireSecuritySignature"
$desiredValue = 1

# Check if the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating path..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Set the registry value
try {
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -Type DWord
    Write-Host "Successfully set '$valueName' to '$desiredValue' at '$regPath'" -ForegroundColor Green
}
catch {
    Write-Error "Failed to set registry value: $_"
}
