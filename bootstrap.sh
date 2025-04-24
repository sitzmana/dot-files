#!/usr/bin/env bash
set -e

OS="$(uname)"
case "$OS" in
  Darwin)
    bash "$PWD/install/macos.sh"
    ;;
  Linux)
    bash "$PWD/install/linux.sh"
    ;;
  *)
    echo "It looks like you’re on $OS. Please run the Windows installer:"
    echo "  powershell -ExecutionPolicy Bypass -File install/windows.ps1"
    exit 1
    ;;
esac

echo "✅ Bootstrap complete!"