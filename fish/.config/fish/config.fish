fish_add_path -a ~/.local/bin
fish_add_path -a ~/.cargo/bin

if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings
    set fish_greeting
end
