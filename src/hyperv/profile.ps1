# If Interactive, set prompt to show ssh connection and current directory
if ($null -ne $Host.UI) {
    #region conda initialize
    # conda slows down my powershell way too much though
    # !! Contents within this block are managed by 'conda init' !!
    # If (Test-Path "C:\ProgramData\mambaforge\Scripts\conda.exe") {
    #   (& "C:\ProgramData\mambaforge\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | ?{$_} | Invoke-Expression
    # }
    #endregion
    Import-Module PSReadLine
    function prompt{
        $cwd = $executionContext.SessionState.Path.CurrentLocation
        $ssh = ""

        if ($env:SSH_CONNECTION) {
            $ssh = "ssh://"
        }
        Write-Host "# $ssh$Env:Username@$env:COMPUTERNAME" -ForegroundColor DarkGray
        Write-Host "# $cwd" -ForegroundColor DarkGray
        Write-Host $env:CONDA_PROMPT_MODIFIER"PS >" -ForegroundColor DarkGreen -NoNewline
        # Write-Host "PS >" -ForegroundColor DarkGreen -NoNewline
        Write-Host $('' * ($nestedPromptLevel + 1)) -ForegroundColor DarkGray -NoNewline
        return " "
    }





}
