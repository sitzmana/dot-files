plugins=(
        git
        zsh-autosuggestions
        web-search
        sudo
        copybuffer
        copyfile
        macos
)
           
source .oh-my-zsh/oh-my-zsh.sh   
# Initialize Starship prompt
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi

source <(fzf --zsh)

jc() { curl -s "$@" | jq .; }
curlqr() { curl -sL "$1" | qrencode -t ansiutf8; }

alias myip='curl -s ifconfig.me'
alias ports='lsof -iTCP -sTCP:LISTEN -P -n'
alias weather='curl wttr.in'
alias cat='bat'
alias ls='eza --long --git --group-directories-first'
eval "$(zoxide init zsh --cmd j)"


#EDITOR
export EDITOR=/usr/bin/vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This load$
# at the end of ~/.zshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $HOME/.goenv
source $HOME/.cargo/env
