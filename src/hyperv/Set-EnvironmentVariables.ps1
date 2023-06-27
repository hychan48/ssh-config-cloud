# Set-EnvironmentVariables.ps1
# very slow script for some reason. also double appends ';'
$pathsToAdd = @(
    'C:\Users\Public\bin'
)
# loop for user / machine
$existingPath = [Environment]::GetEnvironmentVariable('Path', 'User')
#$existingPath = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$currentPaths = $existingPath.Split(';')

foreach ($pathToAdd in $pathsToAdd) {
    if (-not $currentPaths.Contains($pathToAdd)) {
        $currentPaths += $pathToAdd
    }
}

$newPath = $currentPaths -join ';'
[Environment]::SetEnvironmentVariable('Path', $newPath, 'User')
#[Environment]::SetEnvironmentVariable('Path', $newPath, 'Machine')

# merge latter. powershell params are too annoying
# loop for user
<#
[Environment]::GetEnvironmentVariable('Path', 'User')
#>