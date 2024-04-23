if test -d /opt/homebrew
    fish_add_path -gPm /opt/homebrew/bin
    eval (/opt/homebrew/bin/brew shellenv)
else if test -d /home/linuxbrew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end
