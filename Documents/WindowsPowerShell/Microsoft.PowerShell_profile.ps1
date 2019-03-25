#Ensure that Get-ChildItemColor is loaded
Import-Module Get-ChildItemColor

# Set l and ls alias to use the new Get-ChildItemColor cmdlets
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope
Set-Alias sshxavier Ssh-Xavier
Set-Alias sshtx2 Ssh-Tegra

# Import-Module posh-git
Start-SshAgent -Quiet
Add-SshKey "V:\\secure\\phab-private.ppk"

# Add-PSSnapIn Microsoft.HPC

# function Remove-Bom() {
#     # See https://stackoverflow.com/a/5596984.
#     param([string] $Path);
#     $resolved = Resolve-Path $Path;
#     $contents = Get-Content $resolved;
#     $encoding = New-Object System.Text.UTF8Encoding $False;
#     [System.IO.File]::WriteAllLines($resolved, $contents, $encoding);
# }

# Import-Module -Name oh-my-posh
# Set-Theme Agnoster

# if ($Env:TERM_PROGRAM -eq "vscode") {
#     # Fix for the missing "DarkYellow" color in VS Code.
#     $ThemeSettings.Colors["GitLocalChangesColor"] = "White"
# }

$oldPrompt = $Function:prompt;

function prompt() {
    & $oldPrompt;

    if (Get-Command ConEmuC -ErrorAction SilentlyContinue) {
        $gitDir = Get-GitDirectory
        if ($gitDir) {
            $gitRoot = Resolve-Path (Join-Path $gitDir ..)
            $tabTitle = "Repo: $(Split-Path -Leaf $gitRoot)"
        } else {
            $tabTitle = Split-Path -Leaf (Get-Location)
        }

        ConEmuC -GuiMacro Rename 0 "$tabTitle" > $null 2> $null

    }

}


function Ssh-Tegra {
    #$Host.UI.RawUI.backgroundcolor = "DarkRed"
    clear
    echo "########################################`n SSHing into tegra.pensardevelopment.com"
    ssh -i "~/.ssh/phab-private" nvidia@tegra.pensardevelopment.com
    echo "leaving tegra.pensardevelopment.com `n ########################################"
}

function Ssh-Tegra2 {
    #$Host.UI.RawUI.backgroundcolor = "DarkRed"
    clear
    echo "########################################`n SSHing into tegra2.pensardevelopment.com"
    ssh -i "~/.ssh/phab-private" nvidia@tegra2.pensardevelopment.com
    echo "leaving tegra2.pensardevelopment.com `n ########################################"
}
function Ssh-Xavier {
    #$Host.UI.RawUI.backgroundcolor = "DarkGreen"
    clear
    echo "########################################`n SSHing into xavier.pensardevelopment.com"
    ssh -i "~/.ssh/phab-private" nvidia@xavier.pensardevelopment.com
    echo "leaving xavier.pensardevelopment.com `n ########################################"
}


# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
