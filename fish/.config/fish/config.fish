fish_add_path -a ~/.local/bin
fish_add_path -a ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set fish_greeting
end


if test -d $HOME/.sdkman
    function sdk
        bash -c "source '$HOME/.sdkman/bin/sdkman-init.sh'; sdk $argv[1..]"
    end

    fish_add_path (find $HOME/.sdkman/candidates/*/current/bin -maxdepth 0)
end
