#!/usr/bin/env bash
set -e

# Install Homebrew packages
brew bundle --file="$DOTFILES/workflows/ruby/Brewfile"

# Initialize rbenv
if ! command -v rbenv &>/dev/null; then
  echo "rbenv not found in PATH, ensure Homebrew's bin is first"
fi
export RBENV_ROOT="$HOME/.rbenv"
eval "$(rbenv init -)"

# Install latest stable Ruby
LATEST_RUBY=$(rbenv install -l | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
if ! rbenv versions | grep -q "$LATEST_RUBY"; then
  echo "Installing Ruby $LATEST_RUBY…"
  rbenv install "$LATEST_RUBY"
fi
rbenv global "$LATEST_RUBY"

# Install global gems
gem install bundler rake rails rubocop bundler-audit
rbenv rehash