<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 account lockout duration must be configured to 15 minutes or greater.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-23
    Last Modified   : 2025-09-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AC-000005.ps1 
#>

#Account Lockout Policy Setup
# =============================

# Set account will lock after 5 invalid attempts
net accounts /lockoutthreshold:5

# Reset counter after 15 minutes
net accounts /lockoutwindow:15

# Set lockout duration to 15 minutes (or 0)
net accounts /lockoutduration:15

# =============================
# Display the applied settings
# =============================
Write-Host "`nCurrent Account Lockout Policy:"
net accounts
