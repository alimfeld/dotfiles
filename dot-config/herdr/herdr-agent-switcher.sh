#!/usr/bin/env bash
# fzf picker to focus an existing herdr agent pane.
set -euo pipefail

printf '\033]0;Switch Agent\007'

pane=$(herdr agent list 2>/dev/null \
  | jq -r '.result.agents[] | "\(.pane_id)\t\(.agent) [\(.agent_status)] \(.terminal_title_stripped // .cwd)"' \
  | fzf --prompt="agent> " --delimiter='\t' --with-nth=2 --header="Enter = focus agent" \
  | cut -f1)

[ -n "$pane" ] || exit 0

herdr agent focus "$pane" >/dev/null
