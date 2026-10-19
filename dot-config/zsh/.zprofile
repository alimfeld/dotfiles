# Login shells only. /etc/zprofile runs path_helper, which puts /usr/bin first,
# so set PATH here, after it. Non-login shells inherit it.
if [[ -d /opt/homebrew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v brew >/dev/null; then
  eval "$(brew shellenv)"
fi
typeset -U path fpath  # dedupe on assignment
path=(~/.local/opt(N) ~/.local/bin $path)
