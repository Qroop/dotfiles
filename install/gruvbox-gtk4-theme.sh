#!/usr/bin/env bash

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

# To set the theme you need to install user-themes
# https://extensions.gnome.org/extension/19/user-themes/
sudo apt install -y gnome-tweaks
rm -rf "$HOME/.themes"
ln -s "$DOTFILES_DIR/.themes" "$HOME/.themes"
