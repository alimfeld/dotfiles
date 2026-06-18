function k8sc --description "EKS kube context (uses current AWS_PROFILE; pick cluster)"
    if test -z "$AWS_PROFILE"
        echo "k8sc: no AWS_PROFILE set — pick one with awsp first." >&2
        return 1
    end

    set -l cluster (aws eks list-clusters --query 'clusters[]' --output text \
        | tr '\t' '\n' | sort \
        | fzf --prompt="EKS cluster> " --height=~40% --select-1 --exit-0 \
              --header="Profile: $AWS_PROFILE")
    test -z "$cluster"; and return 0

    # Pin the profile into the context name so different roles stay separate contexts.
    aws eks update-kubeconfig --name $cluster \
        --alias "$cluster@$AWS_PROFILE" --user-alias "$cluster@$AWS_PROFILE"
end
