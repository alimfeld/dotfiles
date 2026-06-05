function aws-profile --description "Switch AWS profile (fzf picker or direct argument)"
    set -l profile

    if set -q argv[1]
        set profile $argv[1]
    else
        set profile (aws configure list-profiles | fzf --prompt="AWS profile> " --height=~40% --header="Current: $AWS_PROFILE")
    end

    if test -z "$profile"
        echo "No profile selected." >&2
        return 1
    end

    set -gx AWS_PROFILE $profile
    echo "Switched to $profile"
    aws sts get-caller-identity --query Arn --output text
end
