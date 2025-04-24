#!/usr/bin/env bash
set -e

# 1) Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2) Brew update & core packages
echo "Updating brew & installing CLI tools…"
brew update
brew install \
  git \
  neovim \
  fzf \
  jq \
  qrencode \
  bat \
  eza \
  zoxide \
  broot \
  nvm \
  docker \
  docker-compose

# 3) GUI apps: Docker Desktop, Miniconda
echo "Installing Docker Desktop & Miniconda…"
brew install --cask docker
brew install --cask miniconda

# 4) Nerd Font
echo "Tapping fonts & installing Hack Nerd Font…"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# 5) fzf keybindings/completions
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
  echo "Setting up fzf keybindings & completions…"
  "$(brew --prefix)/opt/fzf/install" --no-bash --no-fish --key-bindings --completion --no-update-rc
fi

# 6) oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Cloning oh-my-zsh…"
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

# 7) starship
if ! command -v starship &>/dev/null; then
  echo "Installing starship…"
  brew install starship
fi

# 8) vim-plug for Vim
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing vim-plug…"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 9) vim-plug for Neovim
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
  echo "Installing vim-plug for Neovim…"
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# 10) Ensure ~/.nvm exists
mkdir -p "$HOME/.nvm"

# 11) Symlink your configs
echo "Symlinking dotfiles…"
ln -sf "$PWD/zsh/.zshrc"                 "$HOME/.zshrc"
ln -sf "$PWD/vim/.vimrc"                 "$HOME/.vimrc"

# Neovim init.vim
mkdir -p "$HOME/.config/nvim"
ln -sf "$PWD/nvim/init.vim"              "$HOME/.config/nvim/init.vim"

mkdir -p "$HOME/.config"
ln -sf "$PWD/starship/starship.toml"     "$HOME/.config/starship.toml"
ln -sf "$PWD/git/.gitconfig"             "$HOME/.gitconfig"
ln -sf "$PWD/git/.gitignore_global"      "$HOME/.gitignore_global"
ln -sf "$PWD/git/.gitmessage.txt"        "$HOME/.gitmessage.txt"

echo "✅ macOS setup complete!"
echo "👉 Don’t forget to set your terminal’s font to “Hack Nerd Font Mono” (or your favorite Nerd Font) in Preferences."