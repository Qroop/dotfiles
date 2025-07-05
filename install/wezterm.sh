#!/usr/bin/env bash
sudo apt install -y curl unzip

FONT_DIR="$HOME/.local/share/fonts"
FONT_FILE="$FONT_DIR/GeistMonoNerdFont-Regular.otf"
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -f "$FONT_FILE" ]; then
    echo "GeistMono font already installed, skipping download."
else
    echo "Installing nerd font..."
    mkdir -p "$FONT_DIR"
    curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/GeistMono.zip
    unzip -d "$FONT_DIR" GeistMono.zip
    rm GeistMono.zip
    fc-cache -fv
    echo "GeistMono font installed."
fi

if command -v wezterm >/dev/null 2>&1; then
    echo "WezTerm is already installed, skipping."
else
    echo "Adding WezTerm repository and installing..."
    curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
    echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
    sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
    sudo apt update
    sudo apt install -y wezterm

    echo "Setting WezTerm as the default terminal emulator..."
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/bin/wezterm 50
    sudo update-alternatives --config x-terminal-emulator
    echo "WezTerm installation complete."

    echo "Symlinking wezterm configuration..."
    rm -rf "$HOME/.config/wezterm"
    ln -s "$DOTFILES_DIR/.config/wezterm" "$HOME/.config/wezterm"
fi

