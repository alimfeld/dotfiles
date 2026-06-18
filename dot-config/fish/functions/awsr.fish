function awsr --description 'Switch AWS region (fzf picker or direct argument; "-" clears)'
    set -l region $argv[1]

    # Clear the override and fall back to the profile's configured region.
    if test "$region" = - -o "$region" = --unset
        set -e AWS_REGION
        set -e AWS_DEFAULT_REGION
        echo "AWS_REGION cleared (using profile default)" >&2
        return 0
    end

    if test -z "$region"
        set region (__awsr_list | \
            fzf --prompt="AWS region> " --height=~40% \
                --select-1 --exit-0 --header="Current: $AWS_REGION  Profile: $AWS_PROFILE" \
            | string split -f1 ' ')
    end

    test -z "$region"; and return 0

    set -gx AWS_REGION $region
    set -gx AWS_DEFAULT_REGION $region
    echo "AWS_REGION=$AWS_REGION" >&2
end
