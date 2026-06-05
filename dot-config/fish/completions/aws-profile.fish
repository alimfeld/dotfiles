# Tab-complete aws-profile with available AWS CLI profiles
complete -c aws-profile -f -a "(aws configure list-profiles)"
