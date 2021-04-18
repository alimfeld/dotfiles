FROM alpine:edge

RUN apk add --no-cache \
  dwm \
  git \
  neovim \
  tmux \
  ttf-dejavu \
  vimb \
  zsh
