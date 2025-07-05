#!/usr/bin/env bash
DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Installing Neovim dependencies..."
sudo apt install -y curl stow

echo "Installing Neovim..."
if command -v nvim >/dev/null 2>&1; then
    echo "Neovim is already installed, skipping download."
else
    echo "Installing neovim"
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
    chmod u+x nvim-linux-x86_64.appimage
    sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim

    echo "Installing Neovim config dependencies..."
    sudo apt install -y make fd-find gcc ripgrep unzip git xclip

    echo "Symlinking Neovim configuration..."
    rm -rf "$HOME/.config/nvim"
    ln -s "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"
fi
