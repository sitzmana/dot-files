#!/usr/bin/env bash
set -e

# 1) Install Homebrew packages
brew bundle --file="$DOTFILES/workflows/go/Brewfile"

# 2) Ensure GOPATH directories
mkdir -p "$HOME/go/bin"

# 3) Install Go tools
export GOPATH="$HOME/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

# Go language server and formatters
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest
go install mvdan.cc/gofumpt@latest

# 4) Ensure goenv is sourced in shells
PROFILE_FILES=("$HOME/.bashrc" "$HOME/.zshrc")
for f in "${PROFILE_FILES[@]}"; do
  grep -qxF 'source $HOME/.goenv' "$f" || echo 'source $HOME/.goenv' >> "$f"
done