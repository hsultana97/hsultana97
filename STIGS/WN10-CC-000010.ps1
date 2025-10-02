<#
.SYNOPSIS
    This PowerShell script ensures that the display of slide shows on the lock screen must be disabled.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-10-02
    Last Modified   : 2025-10-02
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000010 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-CC-000010.ps1 
#>

# PowerShell script to disable lock screen slideshow (WN10-CC-000010)

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization"

# Ensure the registry path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the NoLockScreenSlideshow value to 1 (disable slideshow)
Set-ItemProperty -Path $regPath -Name "NoLockScreenSlideshow" -Value 1 -Type DWord

Write-Host "✅ Lock screen slide show has been disabled (STIG: WN10-CC-000010)."
