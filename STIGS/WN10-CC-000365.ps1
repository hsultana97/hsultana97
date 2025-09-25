<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 must be configured to prevent Windows apps from being activated by voice.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000365 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000365.ps1 
#>

<#
.SYNOPSIS
    Fixes STIG WN10-CC-000365 - Disables voice activation for Windows apps.
#>

# --- Auto-elevate if not running as administrator ---
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Restarting script with administrative privileges..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Define registry path and key ---
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy"

# --- Create key if it doesn't exist ---
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# --- Set the value to disable voice activation above lock ---
Set-ItemProperty -Path $regPath -Name "LetAppsActivateWithVoiceAboveLock" -Value 2 -Type DWord
Write-Host "✅ Disabled voice activation while system is locked (STIG WN10-CC-000365 compliant)."
