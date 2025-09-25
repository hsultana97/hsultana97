<#
.SYNOPSIS
    This PowerShell script ensures that User Account Control must, at minimum, prompt administrators for consent on the secure dektop.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000250

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000250.ps1 
#>

<#
.SYNOPSIS
    Fixes STIG WN10-SO-000250 - Configures UAC to prompt admins for consent on secure desktop.
#>

# --- Auto-elevate if not running as administrator ---
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Restarting script with administrative privileges..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Define registry path ---
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# --- Create path if missing ---
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# --- Set ConsentPromptBehaviorAdmin to 2 (Prompt for consent on secure desktop) ---
Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -Value 2 -Type DWord

Write-Host "✅ UAC is configured to prompt administrators for consent on the secure desktop."
Write-Host "   (STIG WN10-SO-000250 is now compliant.)"
