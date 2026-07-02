#!/usr/bin/env bash
# fzf picker to open a herdr workspace for an existing directory under a base dir.
#
# - Lists subdirectories of BASE_DIR up to DEPTH levels deep (default 2), shown
#   relative to BASE_DIR so nested dirs with the same basename stay distinct.
# - Only existing directories can be selected; it never creates directories.
# - Selecting a dir focuses an existing workspace whose pane is at that dir,
#   or creates a new workspace there.
#
# Usage: herdr-workspace-picker.sh [BASE_DIR] [DEPTH]
set -euo pipefail

BASE_DIR="${1:-${HERDR_WORKSPACE_ROOT:-$HOME/dev}}"
BASE_DIR="${BASE_DIR/#\~/$HOME}"; BASE_DIR="${BASE_DIR%/}"
DEPTH="${2:-${HERDR_WORKSPACE_DEPTH:-2}}"

[ -d "$BASE_DIR" ] || { echo "base dir not found: $BASE_DIR" >&2; exit 1; }

rel=$(
  fd --base-directory "$BASE_DIR" --max-depth "$DEPTH" --type d --hidden --exclude .git \
    | sed 's:/$::' | sort \
    | fzf --prompt="workspace> " --height=100% \
          --header="Enter = open workspace under $BASE_DIR (depth $DEPTH)"
) || true

[ -n "$rel" ] || exit 0

target="$BASE_DIR/$rel"

# Focus an existing workspace with a pane at this dir, else create one.
existing=$(herdr pane list 2>/dev/null \
  | jq -r --arg cwd "$target" '.result.panes[]? | select(.cwd == $cwd) | .workspace_id' \
  | head -n1 || true)

if [ -n "$existing" ]; then
  herdr workspace focus "$existing" >/dev/null
else
  herdr workspace create --cwd "$target" --label "${rel##*/}" --focus >/dev/null
fi
