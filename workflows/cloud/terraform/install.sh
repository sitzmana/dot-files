#!/usr/bin/env bash
set -e

# Determine installation method
if command -v brew &>/dev/null; then
  echo "Installing Terraform and tfenv via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/cloud/terraform/Brewfile"

elif command -v apt &>/dev/null; then
  echo "Adding HashiCorp apt repository…"
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
  sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
  sudo apt update
  echo "Installing Terraform via apt…"
  sudo apt install -y terraform

elif command -v yum &>/dev/null; then
  echo "Adding HashiCorp yum repository…"
  sudo yum install -y yum-utils
  sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
  echo "Installing Terraform via yum…"
  sudo yum install -y terraform

else
  echo "Unsupported OS; please install Terraform manually from https://terraform.io/downloads"
  exit 1
fi

# tfenv: optionally install and set latest stable version
if command -v tfenv &>/dev/null; then
  echo "Installing latest Terraform via tfenv…"
  tfenv install latest
  tfenv use latest
fi

# Enable autocomplete
echo "Setting up Terraform autocomplete…"
terraform -install-autocomplete

# Ensure plugin cache directory
mkdir -p "$HOME/.terraform.d/plugin-cache"

echo "Terraform bootstrap complete."