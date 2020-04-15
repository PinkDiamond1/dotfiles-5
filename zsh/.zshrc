source ~/.aliases

export TERM=xterm-256color

fpath=($HOME/.zsh/gradle-completion $fpath)
fpath=($HOME/.zsh/watson $fpath)
autoload -Uz compinit && compinit

zstyle ':completion:*' menu select
eval "$(dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

source $HOME/.zsh/sudo/sudo.plugin.zsh

setopt auto_cd
. $HOME/.zsh/z/z.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/marvin/.sdkman"
[[ -s "/home/marvin/.sdkman/bin/sdkman-init.sh" ]] && source "/home/marvin/.sdkman/bin/sdkman-init.sh"
# Add golang to the path

export NVM_LAZY_LOAD=true

unalias z
z() {
  if [[ -z "$*" ]]; then
    cd "$(_z -l 2>&1 | fzf +s --tac | sed 's/^[0-9,.]* *//')"
  else
    _last_z_args="$@"
    _z "$@"
  fi
}

zz() {
  cd "$(_z -l 2>&1 | sed 's/^[0-9,.]* *//' | fzf -q "$_last_z_args")"
}

eval "$(starship init zsh)"
