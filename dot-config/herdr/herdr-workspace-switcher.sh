#!/usr/bin/env bash
# fzf picker to focus an existing herdr workspace by label.
set -euo pipefail

printf '\033]0;Switch Workspace\007'

id=$(herdr workspace list 2>/dev/null \
  | jq -r '.result.workspaces[] | "\(.workspace_id)\t\(.label)"' \
  | fzf --prompt="workspace> " --delimiter='\t' --with-nth=2 --header="Enter = focus workspace" \
  | cut -f1)

[ -n "$id" ] || exit 0

herdr workspace focus "$id" >/dev/null
