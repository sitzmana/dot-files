#!/usr/bin/env bash
set -e

# macOS: Homebrew install
if command -v brew &>/dev/null; then
  echo "Installing SSH tools via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/ssh/Brewfile"

# Linux (apt)
elif command -v apt &>/dev/null; then
  echo "Installing SSH via apt…"
  sudo apt update && sudo apt install -y openssh-client keychain

# Linux (yum)
elif command -v yum &>/dev/null; then
  echo "Installing SSH via yum…"
  sudo yum install -y openssh-clients keychain

else
  echo "Unsupported OS; please install SSH client manually."
fi

# Ensure ~/.ssh directory exists
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

echo "SSH environment bootstrap complete."