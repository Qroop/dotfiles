#!/usr/bin/env bash

deps_switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            sudo apt install -y curl unzip
        ;;
        arch)
            sudo pacman -Syu --noconfirm curl unzip
        ;;
        *)
            echo ">> No known distro detected, exiting..."
            return 1
        ;;
    esac
}

wezterm_switch_case () {
    case "$DISTRO_LIKE" in
        debian)
            sudo apt update
            sudo apt install -y wezterm
            echo ">> Adding WezTerm repository and installing..."
            curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
            echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
            sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg

            echo ">> Setting WezTerm as the default terminal emulator..."
            sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 50
            sudo update-alternatives --config x-terminal-emulator
        ;;
        arch)
            sudo pacman -Syu --noconfirm wezterm curl
        ;;
        *)
            echo ">> No known distro detected, exiting..."
            return 1
        ;;
    esac

    echo ">> WezTerm installation complete."
}

main () {
    # Load OS information
    . /etc/os-release

    DISTRO_LIKE=$ID_LIKE # debian arch 
    FONT_DIR="$HOME/.local/share/fonts"
    FONT_FILE="$FONT_DIR/GeistMonoNerdFont-Regular.otf"
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    if ! deps_switch_case; then
        echo ">> No know distro found when installing wezterm deps, exiting..."
        return 
    fi

    if [ -f "$FONT_FILE" ]; then
        echo ">> GeistMono font already installed, skipping download."
    else
        echo ">> Installing nerd font..."
        mkdir -p "$FONT_DIR"
        curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip
        unzip -d "$FONT_DIR" GeistMono.zip
        rm GeistMono.zip
        fc-cache -fv
        echo ">> GeistMono font installed."
    fi

    if command -v wezterm >/dev/null 2>&1; then
        echo ">> WezTerm is already installed, skipping."
        return
    fi

    if ! wezterm_switch_case; then
        echo ">> No distro found when installing wezterm, exiting..."
        return
    fi

    echo ">> Symlinking wezterm configuration..."
    rm -rf "$HOME/.config/wezterm"
    ln -s "$DOTFILES_DIR/.config/wezterm" "$HOME/.config/wezterm"
}

main
