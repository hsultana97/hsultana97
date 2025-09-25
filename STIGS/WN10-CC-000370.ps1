<#
.SYNOPSIS
    This PowerShell script ensures that the convenience PIN for Windows 10 must be disabled.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000370

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000370.ps1 
#>

<#
.SYNOPSIS
    Fixes STIG WN10-CC-000370 - Disables Windows Hello convenience PIN.
#>

# --- Auto-elevate if not running as administrator ---
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Restarting script with administrative privileges..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Define registry path and setting ---
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# --- Create the key if it doesn't exist ---
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# --- Disable convenience PIN sign-in ---
Set-ItemProperty -Path $regPath -Name "AllowDomainPINLogon" -Value 0 -Type DWord
Write-Host "✅ Convenience PIN sign-in has been disabled (STIG WN10-CC-000370 compliant)."
