#!/usr/bin/env bash

DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

rm -rf ~/.gitconfig
ln -s "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
