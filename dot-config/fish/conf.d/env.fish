# Path
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
if test -d ~/.local/opt
  fish_add_path ~/.local/opt
end

# Default programs
set -x EDITOR nvim
set -x VISUAL $EDITOR

# XDG
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_STATE_HOME $HOME/.local/state
