#!/usr/bin/env bash

echo "Installinng dependencies..."

sudo apt update
sudo apt upgrade -y

sudo apt install -y stow

for script in ./install/*.sh; do
    echo "Running $script..."
    bash "$script"
done

echo "Remember to set your default browser to Brave in Settings -> Default Applications"
