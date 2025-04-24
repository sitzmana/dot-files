#!/usr/bin/env bash
set -e

HERE="$(cd "$(dirname "$0")" && pwd)"

OS="$(uname)"
case "$OS" in
  Darwin)
    echo "🛠  macOS bootstrap…"

    # 1) Homebrew
    if ! command -v brew &>/dev/null; then
      echo "  ↪ Installing Homebrew…"
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # 2) Brew update & CLI tools
    echo "  ↪ brew update & install core packages…"
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

    # 3) GUI apps
    echo "  ↪ Install Docker Desktop & Miniconda…"
    brew install --cask docker
    brew install --cask miniconda

    # 4) Nerd Font
    echo "  ↪ Installing Hack Nerd Font…"
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font

    # 5) fzf keybindings & completions
    if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
      echo "  ↪ Setting up fzf keybindings & completions…"
      "$(brew --prefix)/opt/fzf/install" --no-bash --no-fish --key-bindings --completion --no-update-rc
    fi

    # 6) oh-my-zsh
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
      echo "  ↪ Cloning oh-my-zsh…"
      git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
    fi

    # 7) starship
    if ! command -v starship &>/dev/null; then
      echo "  ↪ Installing starship…"
      brew install starship
    fi

    # 8) vim-plug for Vim
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
      echo "  ↪ Installing vim-plug for Vim…"
      curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # 9) vim-plug for Neovim
    if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
      echo "  ↪ Installing vim-plug for Neovim…"
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # 10) Ensure nvm dir
    mkdir -p "$HOME/.nvm"
    ;;

  Linux)
    echo "🛠  Linux bootstrap…"

    # detect package manager
    if command -v apt &>/dev/null; then
      PKG="sudo apt update && sudo apt install -y"
    elif command -v yum &>/dev/null; then
      PKG="sudo yum install -y"
    else
      echo "Unsupported package manager; please install Git, curl, starship, fonts manually."
      exit 1
    fi

    # core packages
    echo "  ↪ Installing core packages…"
    eval "$PKG git curl vim neovim unzip fontconfig"

    # starship
    if ! command -v starship &>/dev/null; then
      echo "  ↪ Installing starship…"
      curl -sS https://starship.rs/install.sh | bash -s -- --yes
    fi

    # vim-plug for Vim
    if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
      echo "  ↪ Installing vim-plug for Vim…"
      curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # vim-plug for Neovim
    if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
      echo "  ↪ Installing vim-plug for Neovim…"
      curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # additional CLI tools
    echo "  ↪ Installing extras (fzf, jq, qrencode, bat, eza, zoxide, broot, nvm, docker)…"
    eval "$PKG fzf jq qrencode bat eza zoxide broot nvm docker docker-compose"

    # Nerd Font
    echo "  ↪ Installing Hack Nerd Font…"
    git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerdfonts
    /tmp/nerdfonts/install.sh Hack
    rm -rf /tmp/nerdfonts
    fc-cache -fv

    # Ensure nvm dir
    mkdir -p "$HOME/.nvm"
    ;;

  *)
    echo "❌ Unsupported OS: $OS"
    exit 1
    ;;
esac

# ——— invoke Dotbot to symlink all your dotfiles ———
echo "🔗 Running Dotbot…"
"$HERE/.dotbot/bin/dotbot" \
  -c "$HERE/install.conf.yaml" \
  --skip-conditions

echo "✅ All done!"