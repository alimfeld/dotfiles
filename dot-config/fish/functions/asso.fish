function asso --description "AWS SSO login (session picker), shows token expiry"
    set -l target $argv[1]

    if test -z "$target"
        set -l choice (__asso_list | fzf --ansi --prompt="SSO login> " --height=~40% --select-1 --exit-0)
        test -z "$choice"; and return 0
        set target (string split -f1 ' ' (string trim "$choice"))
    end

    aws sso login --sso-session $target
end

function __asso_list
    set -l green (set_color green); set -l red (set_color red); set -l off (set_color normal)
    for s in (string match -rg '^\s*\[sso-session\s+(.+?)\s*\]\s*$' < ~/.aws/config)
        set -l cache ~/.aws/sso/cache/(printf '%s' "$s" | shasum | string split -f1 ' ').json
        # python prints two lines: status (active/expired) then the label
        set -l info expired "logged out"
        test -f "$cache"; and set info (python3 -c '
import json, sys
from datetime import datetime, timezone
exp = json.load(open(sys.argv[1])).get("expiresAt")
if not exp:
    print("expired"); print("logged out"); sys.exit()
t = datetime.fromisoformat(exp.replace("Z", "+00:00"))
print("active" if t > datetime.now(timezone.utc) else "expired"); print(t.astimezone().strftime("%Y-%m-%d %H:%M"))
' "$cache")
        if test "$info[1]" = active
            printf '%s\t%s● %s%s\n' "$s" "$green" "$info[2]" "$off"
        else
            printf '%s\t%s○ %s%s\n' "$s" "$red" "$info[2]" "$off"
        end
    end | column -t -s \t
end
