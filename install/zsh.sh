#!/usr/bin/env bash

switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            sudo apt update
            sudo apt install -y zsh 
        ;;
        arch)
            sudo pacman -Syu --noconfirm zsh
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

    echo ">> Installing zsh..."
    if ! switch_case; then
        echo ">> Incompatible distro, exiting..."
        return
    fi

    echo ">> Zsh installed, symlinking to config..."
    rm "$HOME/.zshrc"
    ln -s "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

    rm "$HOME/.zprofile"
    ln -s "$DOTFILES_DIR/.zprofile" "$HOME/.zprofile"

    # Check if Oh My Zsh is already installed
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo ">> Oh My Zsh is already installed, skipping..."
    else
        echo ">> Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        echo ">> Installing oh-my-zsh plugins..."
        git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    fi

    # Set zsh as default shell if not already
    if [ "$SHELL" != "/usr/bin/zsh" ]; then
        echo ">> Setting zsh as default shell..."
        chsh -s /usr/bin/zsh
    else
        echo ">> zsh is already the default shell."
    fi
}

main 
