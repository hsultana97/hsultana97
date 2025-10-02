<#
.SYNOPSIS
    This PowerShell script ensures that PowerShell script block logging must be enabled on Windows 10 .

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-10-02
    Last Modified   : 2025-10-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000326 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000326.ps1 
#>

# PowerShell script to enable script block logging (WN10-CC-000326)

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging"

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Enable script block logging
Set-ItemProperty -Path $regPath -Name "EnableScriptBlockLogging" -Value 1 -Type DWord

Write-Host "✅ PowerShell script block logging has been enabled (STIG: WN10-CC-000326)."
