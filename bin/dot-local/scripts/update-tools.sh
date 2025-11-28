#!/usr/bin/env bash

# Homebrew updates
brew update
brew upgrade

# Pipx updates
pipx upgrade-all

# Helm plugin updates
for p in $(helm plugin list | awk 'NR>1 {print $1}'); do
    echo "Updating $p..."
    helm plugin update "$p"
done
