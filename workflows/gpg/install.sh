#!/usr/bin/env bash
set -e

# macOS: Homebrew
if command -v brew &>/dev/null; then
  echo "Installing GPG & Pinentry via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/gpg/Brewfile"

# Linux (apt)
elif command -v apt &>/dev/null; then
  echo "Installing GPG & Pinentry via apt…"
  sudo apt update && sudo apt install -y gnupg2 pinentry-curses

# Linux (yum)
elif command -v yum &>/dev/null; then
  echo "Installing GPG & Pinentry via yum…"
  sudo yum install -y gnupg pinentry

else
  echo "Unsupported OS; please install GPG manually."
fi

# Ensure GnuPG home directory permissions
echo "Configuring GPG home directory…"
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"

echo "GPG environment bootstrap complete."