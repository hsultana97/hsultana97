<#
.SYNOPSIS
    This PowerShell script ensures that the system must be configured to ignore NetBIOS name release requests except from WIN.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-26
    Last Modified   : 2025-09-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000035 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000035.ps1 
#>

# WN10-CC-000035 Compliance Script
# Configures the system to ignore NetBIOS Name Release requests except from WINS

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\NetBT\Parameters"
$valueName = "NoNameReleaseOnDemand"
$desiredValue = 1

# Check if the registry path exists
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path does not exist. Creating path..." -ForegroundColor Yellow
    New-Item -Path $regPath -Force | Out-Null
}

# Get the current value if it exists
$currentValue = Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue

if ($null -eq $currentValue) {
    Write-Host "Setting '$valueName' to $desiredValue..." -ForegroundColor Green
    New-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null
} elseif ($currentValue.$valueName -ne $desiredValue) {
    Write-Host "Updating '$valueName' from $($currentValue.$valueName) to $desiredValue..." -ForegroundColor Green
    Set-ItemProperty -Path $regPath -Name $valueName -Value $desiredValue
} else {
    Write-Host "'$valueName' is already set to the correct value ($desiredValue)." -ForegroundColor Cyan
}

# Optional: Display final value
$final = Get-ItemProperty -Path $regPath -Name $valueName
Write-Host "`nFinal Value:"
Write-Host "$valueName = $($final.$valueName)" -ForegroundColor White

