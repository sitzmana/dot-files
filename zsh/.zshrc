plugins=(
        git
        zsh-autosuggestions
        web-search
        sudo
        conda
        docker
        copybuffer
        copyfile
        macos
)
           
source $ZSH/oh-my-zsh.sh   
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

source /Users/alexsitzman/.config/broot/launcher/bash/brsource $HOME/.goenv
source $HOME/.goenv
source $HOME/.cargo/env
