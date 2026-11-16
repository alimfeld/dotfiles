# Interactive shell only. Environment is in ~/.zshenv, PATH in .zprofile.

# Completions. macOS' /etc/zshrc does not run compinit.
[[ -d $XDG_CACHE_HOME ]] || mkdir -p $XDG_CACHE_HOME
autoload -Uz compinit
# Keep completion caches out of the repo: ZDOTDIR is dot-config/zsh
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zcompcache
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # case-insensitive
compinit -d $XDG_CACHE_HOME/zcompdump

# History. Overrides the small defaults in /etc/zshrc. Kept out of $ZDOTDIR,
# which is the dotfiles repo (a history file there would dirty the working tree).
[[ -d $XDG_STATE_HOME ]] || mkdir -p $XDG_STATE_HOME
HISTFILE=$XDG_STATE_HOME/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE  # leading space keeps a command (e.g. with a secret) out of history

setopt AUTO_PUSHD PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS
unsetopt BEEP

# Tools
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"  # after prompt setup, per direnv docs

# Aliases
alias vi=nvim vim=nvim lg=lazygit
alias ll='ls -lAhG'
alias la='ls -AG'

# Vi mode. zsh-vi-mode owns the vi keybindings, the block/beam cursor per mode,
# system-clipboard yanks and the mode-switch timing. It initializes while being
# sourced, so everything bound after it below survives.
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_INIT_MODE=sourcing
source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# fzf comes after vi-mode, which overwrites keymaps. fd is faster than find
# and skips .git.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
source <(fzf --zsh)

# Machine-local overrides (e.g. stowed from a work dotfiles repo).
[[ -r ~/.config/local/zsh.zsh ]] && source ~/.config/local/zsh.zsh

# Plugins: syntax highlighting must be sourced last.
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
