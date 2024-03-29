# {{{ Exports
export EDITOR=nvim
export VISUAL=nvim
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.local/scripts"
# }}}

# {{{ Aliases
alias ls="ls -G"
alias ll="ls -lG"
alias vim="nvim"
alias lg="lazygit"
# }}}

# {{{ Directories
# in accordance w/ XDG Base Directory
[ -d "${XDG_CACHE_HOME}/zsh" ] || mkdir -p "${XDG_CACHE_HOME}/zsh"
[ -d "${XDG_STATE_HOME}/zsh" ] || mkdir -p "${XDG_STATE_HOME}/zsh"
# }}}

# {{{ History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="${XDG_STATE_HOME}/zsh/history"
# }}}

# {{{ Completion
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME}/zsh/zcompcache"
autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}" # in accordance w/ XDG Base Directory
# }}}

# {{{ Key Bindings
bindkey -v    # vi key bindings
KEYTIMEOUT=1  # The time the shell waits, in hundredths of seconds, for another
              # key to be pressed when reading bound multi-character sequences.
bindkey -s '^ ' "tmux-sessionizer\n"
# }}}

# {{{ Plugins
# no need for a plugin manager; see also https://github.com/mattmc3/zsh_unplugged
plugins_home="${XDG_DATA_HOME}/zsh/plugins"
plugins=(
    zsh-users/zsh-autosuggestions
    mafredri/zsh-async # required by pure
    sindresorhus/pure
    kutsan/zsh-system-clipboard
    zsh-users/zsh-syntax-highlighting # must be last
)
zsh-plugins-install() {
    for plugin in ${plugins}; do
        if [[ ! -d ${plugins_home}/${plugin} ]]; then
            mkdir -p ${plugins_home}/${plugin%/*}
            git clone --depth 1 https://github.com/${plugin}.git ${plugins_home}/${plugin}
        fi
        source ${plugins_home}/${plugin}/*.plugin.zsh
    done
}
zsh-plugins-update() {
    for plugin in ${plugins}; do
        git -C ${plugins_home}/${plugin} pull
    done
}
zsh-plugins-remove() {
    for plugin in ${plugins_home}/*; do
        rm -rf ${plugin}
    done
}
zsh-plugins-install
# }}}

# vim:fdm=marker
