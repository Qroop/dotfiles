#!/usr/bin/env bash

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

echo "Installing zsh..."
sudo apt update
sudo apt install -y zsh 

echo "Zsh installed, symlinking to config..."
rm -rf "$HOME/.config/zsh"
ln -s "$DOTFILES_DIR/.config/zsh" "$HOME/.config/zsh"
chsh -s /usr/bin/zsh
