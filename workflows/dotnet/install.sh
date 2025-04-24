#!/usr/bin/env bash
set -e

DOTFILES=${DOTFILES:-"$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"}

# macOS via Homebrew
if command -v brew &>/dev/null; then
  echo "Installing .NET SDK & tools via Homebrew…"
  brew update
  brew bundle --file="$DOTFILES/workflows/dotnet/Brewfile"

# Debian/Ubuntu via Microsoft APT
elif command -v apt &>/dev/null; then
  echo "Installing .NET SDK via Microsoft APT…"
  wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O /tmp/packages-microsoft-prod.deb
  sudo dpkg -i /tmp/packages-microsoft-prod.deb
  rm /tmp/packages-microsoft-prod.deb
  sudo apt update
  sudo apt install -y dotnet-sdk-7.0

# RHEL/CentOS via Microsoft RPM
elif command -v yum &>/dev/null; then
  echo "Installing .NET SDK via Microsoft RPM…"
  sudo rpm -Uvh https://packages.microsoft.com/config/rhel/8/packages-microsoft-prod.rpm
  sudo yum install -y dotnet-sdk-7.0

else
  echo "Unsupported OS; please install .NET SDK manually: https://dotnet.microsoft.com/download"
  exit 1
fi

# Install global .NET tools
echo "Installing global .NET tools…"
export PATH="$HOME/.dotnet/tools:$PATH"
dotnet tool install -g dotnet-ef
dotnet tool install -g dotnet-try

# Ensure global tools path in shell profiles
for f in ~/.bashrc ~/.zshrc; do
  grep -qxF 'export PATH="$HOME/.dotnet/tools:$PATH"' "$f" 2>/dev/null || \
    echo 'export PATH="$HOME/.dotnet/tools:$PATH"' >> "$f"
done

echo ".NET/C# environment bootstrap complete."