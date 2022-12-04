# exports
export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export PATH="$PATH:$HOME/.local/bin"

# aliases
alias ls="ls -G"
alias ll="ls -lG"
alias vim="nvim"

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_CACHE_HOME/histfile"

# completion
autoload -Uz compinit && compinit

# vi
bindkey -v
KEYTIMEOUT=1

# keybindings
bindkey -s ^f "tmux-sessionizer\n"

# plugins
PLUGINS_HOME="${XDG_DATA_HOME}/zsh-plugins"
plugins=(
  zsh-users/zsh-autosuggestions
  mafredri/zsh-async # required by pure
  sindresorhus/pure
  kutsan/zsh-system-clipboard
  zsh-users/zsh-syntax-highlighting # must be last
)
zsh-plugins-install() {
  for plugin in $plugins; do
    if [[ ! -d ${PLUGINS_HOME}/$plugin ]]; then
      mkdir -p ${PLUGINS_HOME}/${plugin%/*}
      git clone --depth 1 https://github.com/$plugin.git ${PLUGINS_HOME}/$plugin
    fi
    source ${PLUGINS_HOME}/$plugin/*.plugin.zsh
  done
}
zsh-plugins-update() {
  for plugin in $plugins; do
    git -C ${PLUGINS_HOME}/$plugin pull
  done
}
zsh-plugins-remove() {
  for plugin in ${PLUGINS_HOME}/*; do
    rm -rf $plugin
  done
}
zsh-plugins-install

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init zsh)"
