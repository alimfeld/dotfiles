function awsp --description 'Switch AWS profile (fzf picker or direct argument)'
    set -l profile $argv[1]

    if test -z "$profile"
        set profile (aws configure list-profiles 2>/dev/null | sort | \
            fzf --prompt="AWS profile> " --height=~40% \
                --select-1 --exit-0 --header="Current: $AWS_PROFILE")
    end

    test -z "$profile"; and return 0

    set -gx AWS_PROFILE $profile
    echo "AWS_PROFILE=$AWS_PROFILE" >&2
end
