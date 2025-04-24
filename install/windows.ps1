# install/windows.ps1
Set-ExecutionPolicy Bypass -Scope Process -Force

# ---------------------------
# 1) Git
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Git…"
    winget install --id Git.Git -e --source winget
}

# 2) oh-my-posh
if (-not (Get-Module oh-my-posh -ListAvailable)) {
    Write-Output "Installing oh-my-posh…"
    Install-Module oh-my-posh -Scope CurrentUser -Force
}

# 3) Starship
if (-not (Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Output "Installing starship…"
    winget install --id starship.starship -e --source winget
}

# ---------------------------
# 4) Vim & vim-plug
if (-not (Get-Command vim.exe -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Vim…"
    winget install --id Vim.Vim -e --source winget
}
$vimPlug = "$HOME\vimfiles\autoload\plug.vim"
if (-not (Test-Path $vimPlug)) {
    Write-Output "Installing vim-plug for Vim…"
    New-Item -ItemType Directory -Path (Split-Path $vimPlug) -Force | Out-Null
    Invoke-WebRequest https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim `
        -OutFile $vimPlug
}

# ---------------------------
# 5) Neovim & vim-plug
if (-not (Get-Command nvim.exe -ErrorAction SilentlyContinue)) {
    Write-Output "Installing Neovim…"
    winget install --id Neovim.Neovim -e --source winget
}
$nvimPlug = "$HOME\AppData\Local\nvim\autoload\plug.vim"
if (-not (Test-Path $nvimPlug)) {
    Write-Output "Installing vim-plug for Neovim…"
    $nvimPlugDir = Split-Path $nvimPlug
    New-Item -ItemType Directory -Path $nvimPlugDir -Force | Out-Null
    Invoke-WebRequest https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim `
        -OutFile $nvimPlug
}

# ---------------------------
# 6) Nerd Font via Winget (Hack)
Write-Output "Installing Hack Nerd Font…"
winget install --id NerdFont.Hack -e --source winget `
  -h || Write-Output "Winget install failed; please download a Nerd Font from https://github.com/ryanoasis/nerd-fonts/releases"

# ---------------------------
# 7) Symlink profiles & dotfiles
Write-Output "Symlinking PowerShell profile & configs…"

# PowerShell profile
$profileDir = "$HOME\Documents\PowerShell"
New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
New-Item -ItemType SymbolicLink `
    -Path "$profileDir\Microsoft.PowerShell_profile.ps1" `
    -Target (Resolve-Path "$PSScriptRoot\..\powershell\Microsoft.PowerShell_profile.ps1") `
    -Force | Out-Null

# Vim & Neovim configs
New-Item -ItemType SymbolicLink `
    -Path "$HOME\.vimrc" `
    -Target (Resolve-Path "$PSScriptRoot\..\vim\.vimrc") `
    -Force | Out-Null

# Neovim init.vim (assumes you have nvim\init.vim in your repo)
$nvimConfig = "$HOME\AppData\Local\nvim\init.vim"
New-Item -ItemType Directory -Path (Split-Path $nvimConfig) -Force | Out-Null
New-Item -ItemType SymbolicLink `
    -Path $nvimConfig `
    -Target (Resolve-Path "$PSScriptRoot\..\nvim\init.vim") `
    -Force | Out-Null

# Starship
New-Item -ItemType Directory -Path "$HOME\.config" -Force | Out-Null
New-Item -ItemType SymbolicLink `
    -Path "$HOME\.config\starship.toml" `
    -Target (Resolve-Path "$PSScriptRoot\..\starship\starship.toml") `
    -Force | Out-Null

# Git config & templates
New-Item -ItemType SymbolicLink `
    -Path "$HOME\.gitconfig" `
    -Target (Resolve-Path "$PSScriptRoot\..\git\.gitconfig") `
    -Force | Out-Null

New-Item -ItemType SymbolicLink `
    -Path "$HOME\.gitignore_global" `
    -Target (Resolve-Path "$PSScriptRoot\..\git\.gitignore_global") `
    -Force | Out-Null

New-Item -ItemType SymbolicLink `
    -Path "$HOME\.gitmessage.txt" `
    -Target (Resolve-Path "$PSScriptRoot\..\git\.gitmessage.txt") `
    -Force | Out-Null

Write-Output "✅ Windows setup complete!"
Write-Output "👉 Don’t forget to set your terminal’s font to “Hack Nerd Font Mono” in Windows Terminal settings."