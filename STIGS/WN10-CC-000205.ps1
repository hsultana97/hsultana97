<#
.SYNOPSIS
    This PowerShell script ensures that Windows Telemetry must not be configured to Full.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000205 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000205.ps1 
#>

<#
.SYNOPSIS
    Fixes STIG WN10-CC-000205 - Ensures telemetry is not set to "Full".
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
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# --- Create the key if it doesn't exist ---
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
    Write-Host "Created registry path: $regPath"
}

# --- Set AllowTelemetry to 1 (Basic) ---
Set-ItemProperty -Path $regPath -Name "AllowTelemetry" -Value 1 -Type DWord
Write-Host "✅ Set AllowTelemetry to 1 (Basic) — STIG WN10-CC-000205 is now compliant."
