<#
.SYNOPSIS
    This PowerShell script ensures that User Account Control approval mode for the built-in Administrator must be enabled.

.NOTES
    Author          : Habiba Sultana
    LinkedIn        : linkedin.com/in/habiba-sultana-b074a32a0
    GitHub          : github.com/hsultana97
    Date Created    : 2025-09-23
    Last Modified   : 2025-09-23
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000245 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\STIG-ID-WN10-SO-000245.ps1
#>

<#
.SYNOPSIS
    Enables UAC Approval Mode for the built-in Administrator account
    to comply with Windows 10 STIG requirement WN10-SO-000245.

.DESCRIPTION
    Sets the registry value 'FilterAdministratorToken' to 1 under:
    HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System

.NOTES
    - Must be run with Administrator privileges.
    - May require logoff or reboot to fully apply.
#>

# Function to check if the script is running as Administrator
function Test-IsAdmin {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Ensure script is running with elevated privileges
if (-not (Test-IsAdmin)) {
    Write-Error "❌ This script must be run as Administrator."
    exit 1
}

# Define registry path and key
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$regName = "FilterAdministratorToken"
$desiredValue = 1

# Create the registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    Write-Host "Registry path not found. Creating: $regPath" -ForegroundColor Yellow
    try {
        New-Item -Path $regPath -Force | Out-Null
    } catch {
        Write-Error "❌ Failed to create registry path: $_"
        exit 1
    }
}

# Set the registry value
try {
    Set-ItemProperty -Path $regPath -Name $regName -Value $desiredValue -Type DWord
} catch {
    Write-Error "❌ Failed to set registry value: $_"
    exit 1
}

# Verify the value was set correctly
try {
    $currentValue = Get-ItemProperty -Path $regPath -Name $regName | Select-Object -ExpandProperty $regName
    if ($currentValue -eq $desiredValue) {
        Write-Host "✅ UAC Approval Mode for Built-in Administrator is ENABLED (Value = $currentValue)." -ForegroundColor Green
    } else {
        Write-Host "❌ Failed to apply setting. Current value: $currentValue" -ForegroundColor Red
    }
} catch {
    Write-Error "❌ Error reading registry value: $_"
    exit 1
}
