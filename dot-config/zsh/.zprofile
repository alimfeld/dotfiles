# Login shells only. /etc/zprofile runs path_helper, which rebuilds PATH with
# /usr/bin ahead of Homebrew, so re-assert Homebrew first for login shells
# (Ghostty, tmux). Non-login shells inherit the result; dot-zshenv stays cheap.
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v brew >/dev/null; then
  eval "$(brew shellenv)"
fi
