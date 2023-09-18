#!/bin/bash

get_theme() {
    # Check which waybar theme is set
    THEMEIS=$(readlink -f ~/.config/waybar/style.css | cut -d '-' -f3)

    #if the theme is not dark then we need to switch to it
    if [[ $THEMEIS == "dark.css" ]]; then
        SWITCHTO="-dark"
        MODESTR="Dark"
    else
        SWITCHTO=""
        MODESTR="Light"
    fi
}

update_theme() {
    xfconf-query -c xsettings -p /Net/IconThemeName -s "Papirus-Dark"
    gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

    xfconf-query -c xsettings -p /Net/ThemeName -s "Adwaita$SWITCHTO"
    gsettings set org.gnome.desktop.interface gtk-theme "Adwaita$SWITCHTO"
}

restart_waybar() {
    #restart waybar
    pkill waybar
    waybar & 
    waybar --config ~/.config/dotfiles/waybar/conf/config-lower.jsonc &
}

set_current_background() {
    get_theme
    
    #set the current background
    if [[ $THEMEIS == "dark.css" ]]; then
        swww img ~/.config/dotfiles/backgrounds/background-dark.jpg
    else
        swww img ~/.config/dotfiles/backgrounds/background-light.jpg
    fi
}

# Get args
if [ $# -eq 0 ]; then
    echo "No arguments supplied"
    exit 1
fi

# Set symlinks for all OSes
global_symlinks() {
    echo "Setting symlinks for all OSes..."
    # Git
    ln -sf ~/.config/dotfiles/git/gitconfig ~/.gitconfig
    # Kitty
    ln -sf ~/.config/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
    echo "Done!"
    # Neovim
    ln -sf ~/.config/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
}

# Set symlinks for Hyprland
hypr_symlinks() {
    echo "Setting symlinks for Hyprland..."
    # Hyprland
    ln -sf ~/.config/dotfiles/hypr/hyprland.conf ~/.config/hypr/hyprland.conf
    # Mako
    ln -sf ~/.config/dotfiles/mako/conf/config-dark ~/.config/mako/config
    # Swaylock
    ln -sf ~/.config/dotfiles/swaylock/config ~/.config/swaylock/config
    # Waybar
    ln -sf ~/.config/dotfiles/waybar/conf/config-upper.jsonc ~/.config/waybar/config.jsonc
    ln -sf ~/.config/dotfiles/waybar/style/style-dark.css ~/.config/waybar/style.css
    # Wlogout
    ln -sf ~/.config/dotfiles/wlogout/layout ~/.config/wlogout/layout
    # Wofi
    ln -sf ~/.config/dotfiles/wofi/config ~/.config/wofi/config
    ln -sf ~/.config/dotfiles/wofi/style/style-dark.css ~/.config/wofi/style.css
    # Set the background
    swww img ~/.config/dotfiles/backgrounds/background-light.jpg --transition-fps 60 --transition-type wipe --transition-duration 1
    # Update the sddm image
    cp -f ~/.config/dotfiles/backgrounds/background-light.jpg /usr/share/sddm/themes/sdt/wallpaper.jpg
    echo "Done!"
}

# Restart waybar
if [ $1 == "--restart-waybar" ]; then
    echo "Restarting waybar..."
    restart_waybar
    echo "Done!"
fi


# Set sym links
if [ $1 == "--symlinks" ] && [ $2 == "all" ]; then
    echo "This will set global symlinks and Hyprland symlinks. Continue? (y/n)"
    read -r answer
    if [ $answer != "y" ]; then
        echo "Aborting..."
        exit 1
    fi
    global_symlinks
    hypr_symlinks
fi

if [ $1 == "--symlinks" ] && [ $2 == "global" ]; then
    global_symlinks
fi

if [ $1 == "--symlinks" ] && [ $2 == "hypr" ]; then
    hypr_symlinks
fi
