#!pwsh.exe
<#
PUB_KEY
Run as admin!

# Test snippets
mkdir ~/temp
rm ~/temp/administrators_authorized_keys
cat ~/temp/administrators_authorized_keys
$AUTH_KEY_FILE="~/temp/administrators_authorized_keys"
#>

param (
    [Parameter(Mandatory = $false)]
    [string]$PUB_KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8YNDTSq1BTAA4KFPowIyPGbpwLKtli9Iyk6nyrM4vF jason@DESKTOP-2FU8K8O",

    [Parameter(Mandatory = $false)]
    # [string]$AUTH_KEY_FILE = "C:\ProgramData\ssh\administrators_authorized_keys"
    [string]$AUTH_KEY_FILE = "~/temp/administrators_authorized_keys"
)
# $PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG8YNDTSq1BTAA4KFPowIyPGbpwLKtli9Iyk6nyrM4vF jason@DESKTOP-2FU8K8O"
# $PUB_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEof8LQutxzVOAbX8gKE0ut+ueWmjMCIk42oTrDWK1E2 amd\hoyachan@VDIADMINQ1-01"

# Check if key exists in file
if (Test-Path -Path $AUTH_KEY_FILE) {
    # File exists... grep for $PUB_KEY
    if (!(Get-Content -Path $AUTH_KEY_FILE | Select-String -Raw -SimpleMatch -CaseSensitive $PUB_KEY)) {
        Add-Content -Path $AUTH_KEY_FILE -Value $PUB_KEY
    }
}
else {
    Add-Content -Path $AUTH_KEY_FILE -Value $PUB_KEY
}

Get-Content -Path $AUTH_KEY_FILE

