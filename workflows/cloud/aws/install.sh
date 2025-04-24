#!/usr/bin/env bash
set -e

# Determine OS and install AWS tools
if command -v brew &>/dev/null; then
  echo "Installing AWS CLI and aws-vault via Homebrew…"
  brew update
  brew bundle --file="./workflows/cloud/aws/Brewfile"
elif command -v apt &>/dev/null; then
  echo "Installing AWS CLI via apt…"
  sudo apt update
  sudo apt install -y awscli
  echo "To install aws-vault on Linux, download the binary from https://github.com/99designs/aws-vault/releases"
else
  echo "Unsupported OS: please install awscli and aws-vault manually"
  exit 1
fi