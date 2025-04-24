#!/usr/bin/env bash
set -e

# detect Debian/Ubuntu vs RHEL/CentOS
if command -v apt &>/dev/null; then
  PKG="sudo apt update && sudo apt install -y"
elif command -v yum &>/dev/null; then
  PKG="sudo yum install -y"
else
  echo "Unknown package manager; please install Git, curl, vim, starship and fonts manually."
  exit 1
fi

echo "Installing core packages via package manager…"
eval "$PKG git curl vim neovim unzip fontconfig"

# starship
if ! command -v starship &>/dev/null; then
  echo "Installing starship…"
  curl -sS https://starship.rs/install.sh | bash -s -- --yes
fi

# vim-plug
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
  echo "Installing vim-plug…"
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# vim-plug for neovim
if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim"]; then
    echo "Installing vim-plug for Neovim…"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
# zoxide, fzf, broot, bat, eza, jq, qrencode, nvm, docker
echo "Installing additional CLI tools…"
eval "$PKG fzf jq qrencode bat eza zoxide broot nvm docker docker-compose"

# Nerd Font (Hack)
echo "Installing Hack Nerd Font via Nerd Fonts installer…"
git clone --depth 1 https://github.com/ryanoasis/nerd-fonts.git /tmp/nerdfonts
/tmp/nerdfonts/install.sh Hack
rm -rf /tmp/nerdfonts
fc-cache -fv

# Symlink configs
echo "Symlinking dotfiles…"
ln -sf "$PWD/bash/.bashrc"           "$HOME/.bashrc"
ln -sf "$PWD/vim/.vimrc"             "$HOME/.vimrc"
# Neovim init.vim
mkdir -p "$HOME/.config/nvim"
ln -sf "$PWD/nvim/init.vim"              "$HOME/.config/nvim/init.vim"

mkdir -p "$HOME/.config"
ln -sf "$PWD/starship/starship.toml" "$HOME/.config/starship.toml"
ln -sf "$PWD/git/.gitconfig"        "$HOME/.gitconfig"
ln -sf "$PWD/git/.gitignore_global" "$HOME/.gitignore_global"
ln -sf "$PWD/git/.gitmessage.txt"   "$HOME/.gitmessage.txt"

echo "✅ Linux setup complete!"
echo "👉 Run ‘fc-cache -fv’ if you see any font issues, and select “Hack Nerd Font Mono” in your terminal’s preferences."