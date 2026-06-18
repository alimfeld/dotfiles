# Tab-complete awsp with available AWS CLI profiles
complete -c awsp -f -a "(aws configure list-profiles)"
