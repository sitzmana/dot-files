#!/usr/bin/env bash
set -e

echo "Bootstrapping C/C++ environment…"

# macOS: Homebrew installs
if command -v brew &>/dev/null; then
  brew update
  brew bundle --file="$DOTFILES/workflows/cc/Brewfile"

# Debian/Ubuntu: apt installs
elif command -v apt &>/dev/null; then
  sudo apt update
  sudo apt install -y \
    build-essential cmake ninja-build clang-format clang-tidy ccache gdb cppcheck

# RHEL/CentOS: yum installs
elif command -v yum &>/dev/null; then
  sudo yum install -y \
    gcc gcc-c++ make cmake ninja-build clang gcc-g++ ccache gdb cppcheck

else
  echo "No supported package manager found; please install C/C++ toolchain manually."
  exit 1
fi

# ccache: ensure in PATH (optional)
if ! grep -Fxq 'export PATH="/usr/local/opt/ccache/libexec:$PATH"' ~/.bashrc 2>/dev/null; then
  echo 'export PATH="/usr/local/opt/ccache/libexec:$PATH"' >> ~/.bashrc
fi
if ! grep -Fxq 'export PATH="/usr/local/opt/ccache/libexec:$PATH"' ~/.zshrc 2>/dev/null; then
  echo 'export PATH="/usr/local/opt/ccache/libexec:$PATH"' >> ~/.zshrc
fi

echo "C/C++ toolchain installed."