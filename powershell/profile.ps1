#+++++++++++++++++++++++++++++++++++++++++++++++++++++
#+ PowerShell 5.x user profile
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
# Work out if PowerShell was started with Admin rights.
$fgColor = "Green"
if ($host.UI.RawUI.WindowTitle -match "Administrator") {$fgColor = "DarkRed"}

function prompt {
    # Write Prompt with Path and optional Git branch and command prompt in new line.
    Write-Host "$(Get-Location) " -ForegroundColor $fgColor -NoNewline
    Get-GitBranchName
    Write-Host "`n$([char]0x03BB)" -ForegroundColor White -NoNewline
    return " "
}

function Get-GitBranchName {
    # Work out branch name and status if current folder is a valid git repo.
    $currentBranch = (git branch --show-current *2 $null)
    if ([string]::IsNullOrEmpty($currentBranch)) {return " "}

    # Check if git branch index and working tree are clean.
    if (-not (git status --porcelain)) {
        Write-Host "($currentBranch)" -ForegroundColor White -NoNewline
    } else {
        Write-Host "($currentBranch)" -ForegroundColor Red -NoNewline
    }
}