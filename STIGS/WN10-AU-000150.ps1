<#
.SYNOPSIS
    This PowerShell script ensures that the system must be configured to audit System - Security System Extension successes.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-30
    Last Modified   : 2025-09-30
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000150 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000150.ps1 
#>


# Description: Enable auditing of successful Security System Extension events

$auditCategory = "System"
$auditSubcategory = "Security System Extension"

# Display current setting
$current = auditpol /get /subcategory:"$auditSubcategory"
Write-Host "Current audit setting for '$auditSubcategory':"
Write-Output $current

# Apply the required setting (Success only)
Write-Host "Applying required setting: Success auditing for '$auditSubcategory'..." -ForegroundColor Cyan
auditpol /set /subcategory:"$auditSubcategory" /success:enable

# Verify new setting
Write-Host "`nVerifying new setting..." -ForegroundColor Cyan
auditpol /get /subcategory:"$auditSubcategory"
