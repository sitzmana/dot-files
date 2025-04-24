#!/usr/bin/env bash
set -e

# Load DOTFILES variable
DOTFILES=${DOTFILES:-"$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"}

# 1) Install Homebrew packages (macOS) or Node/Yarn (Linux)
if command -v brew &>/dev/null; then
  echo "Installing Node.js & Yarn via Homebrew…"
  brew update
  brew bundle --file="./workflows/javascript/Brewfile"
elif command -v apt &>/dev/null; then
  echo "Installing Node.js & Yarn via apt…"
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt install -y nodejs
  # Yarn via npm
  sudo npm install -g yarn
else
  echo "Unsupported OS; please install Node.js and Yarn manually."
  exit 1
fi

# 2) Install global Yarn packages
echo "Installing global Yarn packages…"
yarn global add \
  eslint \
  prettier \
  typescript \
  typescript-language-server \
  eslint-config-prettier \
  eslint-plugin-import

# 3) Ensure Yarn bin in PATH
YARN_BIN="$(yarn global bin)"
if ! grep -qxF "export PATH=\"$YARN_BIN:\\$PATH\"" ~/.bashrc 2>/dev/null; then
  echo "export PATH=\"$YARN_BIN:\$PATH\"" >> ~/.bashrc
fi
if ! grep -qxF "export PATH=\"$YARN_BIN:\\$PATH\"" ~/.zshrc 2>/dev/null; then
  echo "export PATH=\"$YARN_BIN:\$PATH\"" >> ~/.zshrc
fi

echo "JavaScript/TypeScript environment bootstrap complete."