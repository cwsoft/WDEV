#+++++++++++++++++++++++++++++++++++++++++++++++++++++
#+ PowerShell 5.x user profile
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
# Work out if PowerShell was started with Admin rights.
$fgColor = "Green"
if ($host.UI.RawUI.WindowTitle -match "Administrator") {$fgColor = "DarkRed"}

function prompt {
    # Write Prompt with Path and optional Git branch and command prompt in new line.
    Write-Host "$(Get-Location) " -ForegroundColor $fgColor -NoNewline
    (GetGitBranchName)
    Write-Host "`n$([char]0x03BB)" -ForegroundColor White -NoNewline
    return " "
}

function GetGitBranchName {
    # Work out branch name and status if current folder is a valid git repo.
    $currentBranch = (git branch --show-current *2 $null)
    if ([string]::IsNullOrEmpty($currentBranch)) {return " "}

    # Check if git index of actual branch and working tree are clean.
    $fgColor = "White"
    if ((git status --porcelain)) { $fgColor = "DarkRed"}
    Write-Host "($currentBranch)" -ForegroundColor $fgColor -NoNewline
}