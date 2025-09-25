<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to audit MPSSVC Rule-Level Policy Change Failures.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000580

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-AU-000580.ps1 
#>

# --- Auto-elevate if not running as administrator ---
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Restarting script with administrative privileges..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Set audit policy for MPSSVC Rule-Level Policy Change (Failure) ---
$subcategory = "MPSSVC Rule-Level Policy Change"
$auditSetting = "Failure"

Write-Host "Setting audit policy for '$subcategory' to '$auditSetting'..."

AuditPol.exe /set /subcategory:"$subcategory" /failure:enable

Write-Host "✅ STIG WN10-AU-000580 is now compliant (Failure auditing enabled for: $subcategory)"
