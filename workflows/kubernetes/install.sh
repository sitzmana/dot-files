#!/usr/bin/env bash
set -e

DOTFILES=${DOTFILES:-"$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"}

if command -v brew &>/dev/null; then
  echo "Installing Kubernetes CLIs via Homebrew…"
  brew update
  brew bundle --file="./workflows/kubernetes/Brewfile"
elif command -v apt &>/dev/null; then
  echo "Installing kubectl & kustomize via apt…"
  sudo apt update
  sudo apt install -y kubectl kustomize
  echo "NOTE: Please install Helm, Skaffold, k9s, kubectx, and stern manually or via their repos."
elif command -v yum &>/dev/null; then
  echo "Installing kubectl & kustomize via yum…"
  sudo yum install -y kubectl kustomize
  echo "NOTE: Please install Helm, Skaffold, k9s, kubectx, and stern manually or via their repos."
else
  echo "Unsupported OS; please install Kubernetes CLIs manually: kubectl, helm, kustomize, etc."
  exit 1
fi

# Enable kubectl autocomplete
if command -v kubectl &>/dev/null; then
  echo "Enabling kubectl autocomplete…"
  kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null || true
fi

# Ensure kube config directory exists
mkdir -p "$HOME/.kube"