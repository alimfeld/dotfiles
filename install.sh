#!/bin/bash

DOTFILES_HOME="$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)"

XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

echo "Setting up XDG Base directories"
echo "  XDG_DATA_HOME  : $XDG_DATA_HOME" 
echo "  XDG_CONFIG_HOME: $XDG_CONFIG_HOME" 
echo "  XDG_CACHE_HOME : $XDG_CACHE_HOME" 

[[ -d $XDG_DATA_HOME   ]] || mkdir -p $XDG_DATA_HOME
[[ -d $XDG_CONFIG_HOME ]] || mkdir -p $XDG_CONFIG_HOME
[[ -d $XDG_CACHE_HOME  ]] || mkdir -p $XDG_CACHE_HOME

echo "Installing nvim config in $XDG_CONFIG_HOME"
ln -s $DOTFILES_HOME/nvim $XDG_CONFIG_HOME

echo "Installing zshrc to $HOME"
ln -s "$DOTFILES_HOME/zsh/zshrc" "$HOME/.zshrc"
