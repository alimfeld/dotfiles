function fish_user_key_bindings
    fish_vi_key_bindings
    bind -M insert -k nul tmux-sessionizer
    bind -M visual -m default y 'fish_clipboard_copy; commandline -f end-selection repaint-mode'
    bind yy fish_clipboard_copy
    bind p fish_clipboard_paste
end
