#!/usr/bin/env bash

switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            sudo apt install -y curl
        ;;
        arch)
            sudo pacman -Syu --noconfirm curl
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

    if command -v brave-browser &> /dev/null; then
        echo ">> Brave browser is already installed"
    else
        if ! switch_case; then
            echo ">> No known distro found, exiting..."
            return 
        fi

        echo ">> Installing Brave browser..."
        curl -fsS https://dl.brave.com/install.sh | sh
        echo ">> Brave browser installed, remember to set it in your default applications..."
    fi
}

main
