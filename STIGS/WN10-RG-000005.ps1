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
    STIG-ID         : WN10-RG-000005 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-RG-000005.ps1 
#>

# Script to check permissions on HKEY_LOCAL_MACHINE (STIG WN10-RG-000005)

$hive = "HKLM:\"

try {
    $acl = Get-Acl -Path $hive
    Write-Host "`n🔍 Current permissions on HKEY_LOCAL_MACHINE:"
    $acl.Access | Format-Table IdentityReference, FileSystemRights, AccessControlType
} catch {
    Write-Error "❌ Failed to get ACL for HKLM: $_"
}
