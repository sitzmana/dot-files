#!/usr/bin/env bash
set -e
brew bundle --file="$DOTFILES/workflows/python/Brewfile"
pipx install pipenv pre-commit