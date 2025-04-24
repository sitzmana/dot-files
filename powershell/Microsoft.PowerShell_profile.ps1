# ─────────────────────────────────────────────────────────────────────────────
# Starship prompt
Invoke-Expression (&starship init powershell)

# ─────────────────────────────────────────────────────────────────────────────
# MODULES: ensure & import core tooling (includes PSFzf now)
$needed = 'PSReadLine','posh-git','Terminal-Icons','PSFzf'
foreach ($mod in $needed) {
    if (-not (Get-Module -ListAvailable -Name $mod)) {
        Write-Verbose "Installing missing module: $mod"
        Install-Module $mod -Scope CurrentUser -Force
    }
    Import-Module $mod -ErrorAction SilentlyContinue
}

# ─────────────────────────────────────────────────────────────────────────────
# PSReadLine tweaks (history, prediction, edit mode)
Set-PSReadLineOption -HistoryNoDuplicates:$true
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -ContinuationPrompt '» '

# ─────────────────────────────────────────────────────────────────────────────
# TAB COMPLETION
# kubectl
kubectl completion powershell | Out-String | Invoke-Expression

# terraform (requires terraform ≥ 0.15)
if (Get-Command terraform -ErrorAction SilentlyContinue) {
    Register-ArgumentCompleter -Native -CommandName terraform -ScriptBlock {
        param($commandName,$wordToComplete,$cursorPosition)
        terraform.exe -generate-autocomplete $wordToComplete
    }
}

# ─────────────────────────────────────────────────────────────────────────────
# COMMON ALIASES
$aliases = @{
    ll    = 'Get-ChildItem -Force -Recurse'
    ls    = 'Get-ChildItem'
    grep  = 'Select-String'
    less  = 'Out-Host -Paging'
    touch = 'New-Item'
    py    = 'python'
    pipi  = 'pip install'
    k     = 'kubectl'
    tf    = 'terraform'
    g     = 'git'
}
foreach ($name in $aliases.Keys) {
    Set-Alias -Name $name -Value $aliases[$name]
}

# ─────────────────────────────────────────────────────────────────────────────
# FUNCTIONS

function Reload-Profile { . $PROFILE }

function Mkcd {
    param([Parameter(Mandatory)][string]$Dir)
    if (-not (Test-Path $Dir)) { New-Item -ItemType Directory -Path $Dir | Out-Null }
    Set-Location $Dir
}

function Extract-Archive {
    param([Parameter(Mandatory)][string]$File)
    if (-not (Test-Path $File)) { Write-Error "$File not found"; return }
    switch -Wildcard ($File) {
        '*.zip'    { Expand-Archive -LiteralPath $File -DestinationPath (Split-Path $File) }
        '*.tar.gz' { tar -xzf $File }
        '*.tar.bz2'{ tar -xjf $File }
        default    { Write-Error "Cannot extract: $File" }
    }
}

# ─────────────────────────────────────────────────────────────────────────────
# PSFzf fuzzy-history search on Ctrl+R
Set-PSReadLineKeyHandler -Key Ctrl+r -Function PSFzfHistorySearch

# ─────────────────────────────────────────────────────────────────────────────
Write-Verbose "Profile loaded: $(Get-Date -Format u)"