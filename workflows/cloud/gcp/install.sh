#!/usr/bin/env bash
set -e

# 1) macOS via Homebrew
type brew &>/dev/null && {
  echo "Installing Google Cloud SDK via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/cloud/gcp/Brewfile"
  exit 0
}

# 2) Debian/Ubuntu via apt
if command -v apt &>/dev/null; then
  echo "Installing Google Cloud SDK via apt…"
  # Add Google Cloud package key and repository
  curl -sS https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  echo "deb https://packages.cloud.google.com/apt cloud-sdk main" |
    sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list
  sudo apt update
  sudo apt install -y google-cloud-sdk
  exit 0
fi

# 3) Fallback
echo "Unsupported OS; please install Google Cloud SDK manually: https://cloud.google.com/sdk/docs/install"
exit 1