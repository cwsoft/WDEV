#+++++++++++++++++++++++++++++++++++++++++++++++++++++
#+ PowerShell 5.x user profile
#+++++++++++++++++++++++++++++++++++++++++++++++++++++
# User defined alias.
Set-Alias -Name touch -Value New-Item

# Work out if PowerShell was started with Admin rights.
if ($host.UI.RawUI.WindowTitle -match "Administrator") {$pathColor = "DarkRed"} else {$pathColor = "Green"}

function prompt {
    # Create multiline command prompt with current path and optional git branch name and status.
    Write-Host "$(Get-Location)" -ForegroundColor $pathColor -NoNewline
    (outputGitBranchName)
    # Output Unicode "Lambda" char into new line as default prompt.
    Write-Host "`n$([char]0x03BB)" -ForegroundColor White -NoNewline
    return " "
}

function outputGitBranchName {
    Try {
        # Try to extract git branch if current path is a valid git repo.
        $currentBranch = (git branch --show-current 2>$null)
        if ($currentBranch) {
            # Check if index and working tree are clean.
            if ((git status --porcelain)) { $branchColor = "DarkRed"} else { $branchColor = "White"}
            # Indicate if branch is clean by setting branch name color to white (clean) or red.
            Write-Host " ($currentBranch)" -ForegroundColor $branchColor -NoNewline
        }
    } Catch {
        # Skip on errors (e.g. git not installed/accessible, insufficient permissions ...).
        return " "
    }
}