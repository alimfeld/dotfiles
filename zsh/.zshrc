# aliases
alias ll="ls -lG"
alias vim="nvim"

# exports
export EDITOR=nvim

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/histfile

# completion
autoload -Uz compinit && compinit

# plugins (install w/ your package manager of choice and symlink)
source ~/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# vi
bindkey -v
KEYTIMEOUT=5
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
   [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
     [[ ${KEYMAP} == viins ]] ||
     [[ ${KEYMAP} = '' ]] ||
     [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
_fix_cursor() {
   echo -ne '\e[5 q'
}
precmd_functions+=(_fix_cursor)

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{240}(%b)%r%f'
zstyle ':vcs_info:*' enable git
