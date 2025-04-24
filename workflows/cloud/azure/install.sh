#!/usr/bin/env bash
set -e

# Install Azure CLI
if command -v brew &>/dev/null; then
  echo "Installing Azure CLI via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/cloud/azure/Brewfile"
elif command -v apt &>/dev/null; then
  echo "Installing Azure CLI via Microsoft apt repository…"
  # import Microsoft signing key and repository
  curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor >/tmp/microsoft.gpg
  sudo install -o root -g root -m 644 /tmp/microsoft.gpg /usr/share/keyrings/
  AZ_REPO=$(lsb_release -cs)
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" |
    sudo tee /etc/apt/sources.list.d/azure-cli.list
  sudo apt update
  sudo apt install -y azure-cli
  rm /tmp/microsoft.gpg
else
  echo "Unsupported OS; please install Azure CLI manually: https://aka.ms/InstallAzureCLI"
  exit 1
fi