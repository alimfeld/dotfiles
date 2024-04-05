function fish_prompt
    # store status
    set -l last_status $status

    # configure colors
    set cwd_color (set_color -o blue)
    set git_branch_color (set_color -o brblack)
    set git_dirty_color (set_color -o yellow)
    set git_ahead_color (set_color -o blue)
    set success_color (set_color -o magenta)
    set failure_color (set_color -o red)

    # cwd component
    set cwd $cwd_color(prompt_pwd)

    # git_info component
    set git_branch (_git_branch)
    if [ git_branch ]
        set git_info $git_branch_color$git_branch
        if [ (_is_git_dirty) ]
            set git_info "$git_info$git_dirty_color*"
        end
        set git_info "$git_info $git_ahead_color$(_git_ahead)"
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
    set -l commits (command git rev-list --left-right '@{upstream}...HEAD' 2>/dev/null)
    if [ $status != 0 ]
        return
    end
    set -l behind (count (for arg in $commits; echo $arg; end | grep '^<'))
    set -l ahead (count (for arg in $commits; echo $arg; end | grep -v '^<'))
    switch "$ahead $behind"
        case '' # no upstream
        case '0 0' # equal to upstream
            return
        case '* 0' # ahead of upstream
            echo "⇡"
        case '0 *' # behind upstream
            echo "⇣"
        case '*' # diverged from upstream
            echo "⇡⇣"
    end
end

function _git_branch
    echo (command git symbolic-ref HEAD 2>/dev/null | sed -e 's|^refs/heads/||')
end

function _is_git_dirty
    echo (command git status -s --ignore-submodules=dirty 2>/dev/null)
end
