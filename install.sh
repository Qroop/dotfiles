#!/usr/bin/env bash
LOGFILE="$HOME/install.log"

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

echo "Installing dependencies..."

sudo apt update
sudo apt upgrade -y
sudo apt install -y stow

for script in ./install/*.sh; do
    echo "Running $script..."
    bash "$script"
done

echo "Remember to set your default browser to Brave in Settings -> Default Applications"
