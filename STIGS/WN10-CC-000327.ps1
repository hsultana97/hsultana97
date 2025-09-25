<#
.SYNOPSIS
    This PowerShell script ensures that PowerShell Transcription must be enabled on Windows 10.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-25
    Last Modified   : 2025-09-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000327 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000327.ps1 
#>

# --- Auto-elevate if not running as administrator ---
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(
    [Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Warning "Restarting script with administrative privileges..."
    Start-Process powershell "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# --- Define registry path and values ---
$transcriptionRegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription"
$transcriptOutputDir = "C:\Transcripts"

# --- Create registry key if it doesn't exist ---
if (-not (Test-Path $transcriptionRegPath)) {
    New-Item -Path $transcriptionRegPath -Force | Out-Null
    Write-Host "Created registry path: $transcriptionRegPath"
}

# --- Enable PowerShell transcription ---
Set-ItemProperty -Path $transcriptionRegPath -Name "EnableTranscripting" -Value 1 -Type DWord
Write-Host "Enabled PowerShell transcription."

# --- Create output directory if needed ---
if (-not (Test-Path $transcriptOutputDir)) {
    New-Item -Path $transcriptOutputDir -ItemType Directory -Force | Out-Null
    Write-Host "Created transcript output directory: $transcriptOutputDir"
}

# --- Set output directory in registry ---
Set-ItemProperty -Path $transcriptionRegPath -Name "OutputDirectory" -Value $transcriptOutputDir -Type String
Write-Host "Set output directory for transcripts."

# --- Compliance Check ---
$enabled = Get-ItemProperty -Path $transcriptionRegPath -Name "EnableTranscripting" -ErrorAction SilentlyContinue

if ($enabled.EnableTranscripting -eq 1) {
    Write-Host "`n✅ STIG WN10-CC-000327 is COMPLIANT (PowerShell Transcription is enabled)."
    Write-Host "   Transcripts will be saved to: $transcriptOutputDir`n"
} else {
    Write-Host "`n❌ STIG WN10-CC-000327 is NOT compliant (Transcription not enabled).`n"
}
