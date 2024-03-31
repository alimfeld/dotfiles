export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# XDG Base Directory (see https://wiki.archlinux.org/title/XDG_Base_Directory for a nice overview)
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Don't call compinit in /etc/zsh/zshrc; we call it ourselves
skip_global_compinit=1
