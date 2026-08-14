# Add fastfetch as a greeting
function fish_greeting
    fastfetch
    echo
    eza --icons
end

#Replacement shit
alias rm='trash-put'
alias ls='eza --icons'
alias ll='eza -lh --icons'
alias tree='eza --tree --icons'
alias cat='bat'
alias htop='btop'
alias cl='clear; fastfetch; echo ""; ls'
alias start='dbus-run-session start-hyprland'
alias cll='cd; clear; fastfetch; echo""; ls'

function last_history_item
    echo $history[1]
end
abbr -a !! --position anywhere --function last_history_item

function cd
    # 1. If you just type 'cd' with nothing else, go home
    if test (count $argv) -eq 0
        builtin cd ~
        ls
        return
    end

    # 2. Does this exact folder exist right here?
    if test -d $argv[1]
        # If yes, walk in, THEN look around
        builtin cd $argv
        ls
        return
    end

    # 3. If it's not here, ask Zoxide for the teleport coordinates
    set target_path (zoxide query $argv 2>/dev/null)

    # 4. Did Zoxide find a path?
    if test -n "$target_path"
        builtin cd $target_path
        ls
    else
        # 5. If Zoxide is stumped, try normal cd (which will throw the native error)
        # We DO NOT put ls here, because we know the cd is about to fail!
        builtin cd $argv
    end
end

# Init shit
zoxide init fish | source
starship init fish | source


# Run hyprland on startup

#if status is-login
#    if test (tty) = /dev/tty1
#        exec dbus-run-session start-hyprland
#    end
#end
