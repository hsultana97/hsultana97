<#
.SYNOPSIS
    This PowerShell script ensures that The default autorun behavior must be configured to prevent autorun commands.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-23
    Last Modified   : 2025-09-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000185 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000185.ps1 
#>
# Run this script as Administrator

# =============================
# Disable AutoRun via Registry
# =============================

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer"
$valueName = "NoAutorun"
$valueData = 1

# Create the key if it doesn't exist
If (-Not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set NoAutorun to 1 (disables execution of autorun commands)
Set-ItemProperty -Path $registryPath -Name $valueName -Value $valueData -Type DWord

# =============================
# Confirm the setting
# =============================
Write-Host "`n[✔] AutoRun disabled (NoAutorun = 1) at:`n$registryPath" -ForegroundColor Green
Get-ItemProperty -Path $registryPath | Select-Object $valueName
