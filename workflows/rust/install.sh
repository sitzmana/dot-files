#!/usr/bin/env bash
set -e

# Ensure Homebrew packages are installed
brew bundle --file="./workflows/rust/Brewfile"

# Install or update rustup
if ! command -v rustup &>/dev/null; then
  echo "Installing rustup…"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

# Ensure ~/.cargo/env is loaded in your shell profile
grep -qxF 'source $HOME/.cargo/env' ~/.bashrc  || echo 'source $HOME/.cargo/env' >> ~/.bashrc
grep -qxF 'source $HOME/.cargo/env' ~/.zshrc   || echo 'source $HOME/.cargo/env' >> ~/.zshrc