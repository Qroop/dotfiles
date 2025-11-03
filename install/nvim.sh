#!/usr/bin/env bash

dependency_switch_case () {
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

neovim_switch_case () {
    echo ">> Installing neovim"
    case "$DISTRO_LIKE" in
        debian)
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
            chmod u+x nvim-linux-x86_64.appimage
            sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

            echo ">> Installing Neovim config dependencies..."
            sudo apt install -y make fd-find gcc ripgrep unzip git xclip npm
        ;;
        arch)
            sudo pacman -Syu --noconfirm nvim make fd gcc ripgrep unzip git xclip npm 
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

    if ! dependency_switch_case; then
        echo ">> No known distro found when installing neovim deps, exiting..."
        return 
    fi

    if ! neovim_switch_case; then
        echo ">> No known distro found when installing nvim, exiting..."
        return
    fi

    echo ">> Symlinking Neovim configuration..."
    rm -rf "$HOME/.config/nvim"
    ln -s "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
}

main
