#!/usr/bin/env bash

main () {
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    echo ">> Symlinking i3 config..."
    rm -rf "$HOME/.config/i3"
    ln -s "$DOTFILES_DIR/.config/i3" "$HOME/.config/i3"

    echo "Setting transparency effects..."
    sudo pacman -Syu --noconfirm picom
    rm -rf "$HOME/.config/picom"
    ln -s "$DOTFILES_DIR/.config/picom" "$HOME/.config/picom"

    echo ">> Setting loging screen background"
    sudo rm -rf /etc/lightdm/slick-greeter.conf
    sudo mkdir /usr/share/backgrounds
    sudo cp "$DOTFILES_DIR/static/pictures/forest-mountain-cloudy-valley.png" /usr/share/backgrounds
    sudo ln -s "$DOTFILES_DIR/static/i3/slick-greeter.conf" "/etc/lightdm/slick-greeter.conf"

    echo ">> Setting rofi theme"
    rm -rf "$HOME/.config/rofi"
    ln -s "$DOTFILES_DIR/.config/rofi" "$HOME/.config/rofi"

    echo ">> Symlinking gtk3"
    rm -rf "$HOME/.config/gtk-3.0"
    ln -s "$DOTFILES_DIR/.config/gtk-3.0" "$HOME/.config/gtk-3.0"

    echo ">> Symlinking Gruvbox themes"
    # Symlink the whole .themes directory first
    rm -rf "$HOME/.themes"
    ln -s "$DOTFILES_DIR/.themes" "$HOME/.themes"

    # Then set up gtk-4.0 by copying or symlinking into ~/.config
    rm -rf "$HOME/.config/gtk-4.0"
    ln -s "$HOME/.themes/Gruvbox-Green-Dark/gtk-4.0" "$HOME/.config/gtk-4.0"

    echo ">> Downloading Gruvbox Icons pack"
    yay -S --noconfirm gruvbox-plus-icons-theme-git
}

main
