# Interactive shell only. Environment setup (PATH, XDG, EDITOR) is in ~/.zshenv.

# Completions. macOS' /etc/zshrc does not run compinit.
[[ -d $XDG_CACHE_HOME ]] || mkdir -p $XDG_CACHE_HOME
autoload -Uz compinit
compinit -d $XDG_CACHE_HOME/zcompdump

# History. Overrides the small defaults in /etc/zshrc. Kept out of $ZDOTDIR,
# which is the dotfiles repo (a history file there would dirty the working tree).
[[ -d $XDG_STATE_HOME ]] || mkdir -p $XDG_STATE_HOME
HISTFILE=$XDG_STATE_HOME/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_EXPIRE_DUPS_FIRST HIST_REDUCE_BLANKS

setopt AUTO_PUSHD PUSHD_IGNORE_DUPS INTERACTIVE_COMMENTS
unsetopt BEEP

# Tools
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

# Aliases
alias vi=nvim vim=nvim lg=lazygit wm=workmux

# <Ctrl-Space>: tmux session picker
function sesh-pick() {
  local session
  session=$(sesh list --icons | fzf --ansi) || return
  [[ -n $session ]] && sesh connect "$session"
}
zle -N sesh-pick

# Vi mode. zsh-vi-mode owns the vi keybindings, the block/beam cursor per mode,
# system-clipboard yanks and the mode-switch timing. It initializes while being
# sourced, so everything bound after it below survives.
ZVM_SYSTEM_CLIPBOARD_ENABLED=true
ZVM_INIT_MODE=sourcing
source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# fzf and the picker binding come after vi-mode, which overwrites keymaps.
source <(fzf --zsh)
bindkey -M viins '^@' sesh-pick

# Plugins: syntax highlighting must be sourced last.
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
