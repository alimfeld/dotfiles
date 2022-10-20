# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# completion
autoload -Uz compinit && compinit

# colors
autoload -Uz colors && colors

# prompt
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
zstyle ':vcs_info:git:* ' formats '%b '
PROMPT='%B%F{240}%1~%f%b $vcs_info_msg_0_➟ '

# plugins (install w/ your package manager of choice and symlink)
source ~/.local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
