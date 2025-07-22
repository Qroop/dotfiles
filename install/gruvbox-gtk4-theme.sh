#!/usr/bin/env bash

switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            sudo apt install -y gnome-tweaks
            rm -rf "$HOME/.themes"
            ln -s "$DOTFILES_DIR/.themes" "$HOME/.themes"
        ;;
        *)
            echo ">> No known distro detected, exiting..."
            return 1
        ;;
    esac
} 

main () {
    # Load OS information
    . /etc/os-release

    DISTRO_LIKE=$ID_LIKE # debian arch 
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    if ! switch_case; then
        echo ">> No know distro found, exiting..."
        return
    fi

    # To set the theme you need to install user-themes
    # https://extensions.gnome.org/extension/19/user-themes/
}

main
