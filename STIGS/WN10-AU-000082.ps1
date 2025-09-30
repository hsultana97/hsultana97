<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to audit Object Access - File Share successes.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-30
    Last Modified   : 2025-09-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000082 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000082.ps1 
#>

# Description: Enables auditing for successful File Share access

$auditCategory = "Object Access"
$auditSubcategory = "File Share"

# Check current setting
$currentSetting = auditpol /get /subcategory:"$auditSubcategory"

Write-Host "Current audit setting for '$auditSubcategory':"
Write-Output $currentSetting

# Enable Success auditing
Write-Host "Enabling Success auditing for '$auditSubcategory'..." -ForegroundColor Cyan
auditpol /set /subcategory:"$auditSubcategory" /success:enable

# Verify the setting was applied
Write-Host "`nVerifying updated setting..." -ForegroundColor Cyan
auditpol /get /subcategory:"$auditSubcategory"
