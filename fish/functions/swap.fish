function swap --description "Toggle between MacOS and Minecraft themes across the system"
    # Alacritty Paths
    set alacritty_link ~/.config/alacritty/current_theme.toml
    set alacritty_mac ~/.config/alacritty/macos.toml
    set alacritty_mc ~/.config/alacritty/minecraft.toml

    # Hyprland Paths
    set hypr_link ~/.config/hypr/current_theme.conf
    set hypr_mac ~/.config/hypr/macos.conf
    set hypr_mc ~/.config/hypr/minecraft.conf

    # Determine which theme to switch to based on Alacritty's current state
    if not test -e $alacritty_link; or test (realpath $alacritty_link) = $alacritty_mac
        # -> SWAP TO MINECRAFT (DARK)
        killall swaybg
        swaybg -i ~/.config/dark.jpg -m fill & disown # Add your dark wallpaper path here
        
        ln -sf $alacritty_mc $alacritty_link
        ln -sf $hypr_mc $hypr_link
        
        # NEOVIM: High-Contrast Dark
        set nvim_cmd "set background=dark | colorscheme tokyonight-night"
        
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
        echo "⛏️  Switched to Minecraft Glassy"
    else
        # -> SWAP TO MACOS (LIGHT)
        killall swaybg
        swaybg -i ~/.config/light.jpg -m fill & disown
        
        ln -sf $alacritty_mac $alacritty_link
        ln -sf $hypr_mac $hypr_link
        
        # NEOVIM: High-Contrast Light
        set nvim_cmd "set background=light | colorscheme tokyonight-day"
        
        gsettings set org.gnome.desktop.interface color-scheme 'prefer-light'
        echo "🍏 Switched to macOS Light"
    end

    # 1. Reload Hyprland instantly
    hyprctl reload >/dev/null 2>&1

    # 2. Live-update all running Neovim instances
    if set -q XDG_RUNTIME_DIR
        for server in $XDG_RUNTIME_DIR/nvim.*.0
            if test -S $server
                nvim --server $server --remote-expr "execute('$nvim_cmd')" >/dev/null 2>&1
            end
        end
    end
end
