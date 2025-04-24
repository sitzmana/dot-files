# ~/.bashrc

# 1) Only load in interactive shells
[[ $- != *i* ]] && return

# 2) Basic environment
export EDITOR=vim
export VISUAL="$EDITOR"
export PAGER=less
export LANG=en_US.UTF-8

# 3) History settings
HISTSIZE=5000                     # number of lines in memory
HISTFILESIZE=20000                # number of lines in disk file
HISTCONTROL=ignoredups:erasedups  # no duplicate entries
HISTIGNORE="&:[ ]*:exit"          # ignore certain commands
shopt -s histappend                # append rather than overwrite

# 4) Shell options
shopt -s checkwinsize    # update LINES and COLUMNS after resize
shopt -s globstar        # ** recursive globbing
shopt -s autocd          # type dir name to cd

# 5) Prompt (Starship)  
if command -v starship &>/dev/null; then
  eval "$(starship init bash)"
else
  # fallback PS1
  PS1='\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\$ '
fi

# 6) Path additions
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# 7) Load nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# 8) Load Conda if installed
if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
  . "$HOME/miniconda3/etc/profile.d/conda.sh"
fi

# 9) Load zoxide for smart directory jumps
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init bash)"
fi

# 10) fzf keybindings & completion (if installed)
if [ -f /usr/share/fzf/key-bindings.bash ]; then
  source /usr/share/fzf/key-bindings.bash
  source /usr/share/fzf/completion.bash
fi

# 11) Git completion & prompt helper
if [ -f /usr/share/bash-completion/completions/git ]; then
  source /usr/share/bash-completion/completions/git
fi

# 12) Aliases – keep them short and memorable
alias ll='ls -lah --group-directories-first'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gp='git push'
alias myip='curl -s ifconfig.me'
alias ports="lsof -iTCP -sTCP:LISTEN -P -n"
alias weather='curl wttr.in?0'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

# 13) Handy functions
# Quick JSON pretty-print
jc() { curl -s "$@" | jq .; }

# URL → QR code in terminal
curlqr() { curl -sL "$1" | qrencode -t ansiutf8; }

# Extract archives by extension
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"    ;;
      *.tar.gz)    tar xvzf "$1"    ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xvf "$1"     ;;
      *.tbz2)      tar xvjf "$1"    ;;
      *.tgz)       tar xvzf "$1"    ;;
      *.zip)       unzip "$1"       ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "Cannot extract '$1'" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# 14) Enhance ↑/↓ to search history by prefix
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# 15) Final load of ~/.bash_aliases if you want to split more out
[ -f ~/.bash_aliases ] && source ~/.bash_aliasessource $HOME/.goenv
source $HOME/.goenv
source $HOME/.cargo/env
