# Tab-complete awsr with the curated region list (code only) plus the clear flag
complete -c awsr -f -a "(__awsr_list | string split -f1 ' ')"
complete -c awsr -f -a "--unset" -d "Clear region override (use profile default)"
