<#
    Basic tree... not really tree structure but a list of files and folders
#>
function Get-Tree {
    param (
        [Parameter(Mandatory = $true)]
        # verify that the path is a directory...
        [ValidateScript({Test-Path -Path $_ -PathType 'Container'})]
        [string]$Directory,
        # limiting for my purposes
        [Parameter()]
        [int]$TopLimitFirst = 30
    )

    $items=(Get-ChildItem -Path $Directory -Recurse -ErrorAction Stop | Select-Object -Property FullName -First $TopLimitFirst)
    # write-host $items
    $items
    if ($items.Count -eq 0) {
        Write-Host "($Directory is empty)"
    }

    # try {
        # not needed because of the paramter validation
    # } catch {
    #     # this dosent actually get called. because of the paramter test-path... nice
    #     Write-Error "An error occurred while retrieving child items: $_"
    # }
}
Get-Tree ~/ -TopLimitFirst 1
Get-Tree ~/tmp
# Get-Tree ~/tmpssfsdf # 