#!/usr/bin/env bash

# Homebrew installation
brew install --cask wezterm --appdir=~/Applications
brew install --cask brave-browser --appdir=~/Applications
brew install \
    ansifilter \
    aws-sso-util \
    awscli \
    awsume \
    bash-language-server \
    bat \
    black \
    delta \
    derlin/bitdowntoc/bitdowntoc \
    direnv \
    fd \
    fish \
    fzf \
    git \
    go-task \
    gomplate \
    gsed \
    helm \
    helm-docs \
    helm-ls \
    helmfile \
    jinja2-cli \
    k6 \
    k9s \
    kubectl \
    lazygit \
    lua-language-server \
    neovim \
    pipx \
    prettier \
    pylint \
    pyright \
    python-setuptools \
    rg \
    ruff \
    shellcheck \
    shfmt \
    stow \
    terraform-docs \
    terraform-ls \
    tfenv \
    tflint \
    tmux \
    typescript-language-server \
    vscode-langservers-extracted \
    yaml-language-server \
    yq

# Pipx installation
pipx install python-lsp-server
pipx inject python-lsp-server pylint

# Helm plugin installation
helm plugin install https://github.com/databus23/helm-diff --verify=false
helm plugin install https://github.com/dadav/helm-schema --verify=false
