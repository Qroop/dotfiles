#!/usr/bin/env bash

distro_switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            echo ">> Updating xkb-data"
            sudo dpkg-reconfigure xkb-data
        ;;
        arch)
            echo ">> No xkb-data update needed on Arch"
        ;;
        *)
            echo ">> No known distro detected, exiting"
            return 1
        ;;
    esac
}

main () {
    set -e

    # Load OS information
    . /etc/os-release

    DISTRO_LIKE=$ID_LIKE # debian arch 
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    echo ">> Installing Swedish (Coder) keyboard layout variant"

    SYMBOLS_FILE="/usr/share/X11/xkb/symbols/se"
    VARIANT_NAME="coder"
    LAYOUT_MARKER="xkb_symbols \"$VARIANT_NAME\""

    if ! grep -q "$LAYOUT_MARKER" "$SYMBOLS_FILE"; then
        echo ">> Appending custom variant to $SYMBOLS_FILE"
        sudo bash -c "cat \"$PWD/../xkb/se-coder.xkb\" >> \"$SYMBOLS_FILE\""
    else
        echo ">> Variant already present, skipping patch."
    fi

    if ! distro_switch_case; then
        return
    fi
    
    echo ">> Making layout persistent using localectl"

    if [[ "$XDG_CURRENT_DESKTOP" == "KDE" && "$XDG_SESSION_TYPE" == "wayland" ]]; then
        echo ">> Detected KDE on Wayland."
        echo ">> Use System Settings > Input Devices > Layouts"
        echo "   to select Swedish layout with 'coder' variant to persist it."
        return
    fi

    echo ">> Done. Set layout with: setxkbmap se coder"
    setxkbmap se coder

    sudo localectl set-x11-keymap se $VARIANT_NAME
}

main
