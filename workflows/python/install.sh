#!/usr/bin/env bash
set -e
brew bundle --file="./workflows/python/Brewfile"
pipx install pipenv pre-commit