function fish_prompt
    # store status
    set last_status $status

    # configure colors
    set cwd_color (set_color brblue)
    set git_branch_color (set_color brblack)
    set git_indicator_color (set_color yellow)
    set success_color (set_color -o magenta)
    set failure_color (set_color -o red)
    set normal_color (set_color normal)

    # cwd component
    set cwd $cwd_color(prompt_pwd)$normal_color

    # git_info component
    set git_branch (_git_branch)
    if [ git_branch ]
        set git_info $git_branch_color$git_branch$git_indicator_color
        if [ (_is_git_dirty) ]
            set git_info "$git_info*"
        end
        set git_info "$git_info $(_git_ahead)"
    end

    # prompt component
    if test $last_status = 0
        set prompt "$success_color❯"
    else
        set prompt "$failure_color❯"
    end

    # assemble full prompt
    echo -n -s $cwd ' ' $git_info \n $prompt ' '
end

function _git_ahead
    set ahead_behind (command git rev-list --left-right --count HEAD...@'{u}' 2>/dev/null)
    if [ $status != 0 ]
        return
    end
    set counts (string split \t -- $ahead_behind)
    switch "$counts[1] $counts[2]"
        case "0 0" # equal to upstream
            return
        case '* 0' # ahead of upstream
            echo "↑$counts[1]"
        case '0 *' # behind upstream
            echo "↓$counts[2]"
        case '*' # diverged from upstream
            echo "↑$counts[1]↓$counts[2]"
    end
end

function _git_branch
    set branch (command git symbolic-ref --quiet HEAD 2>/dev/null)
    switch $status
        case 0
            echo (string replace -r '^refs/heads/' '' $branch)
        case 1
            echo (git rev-parse --short HEAD 2>/dev/null)
    end
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
