#!/usr/bin/env bash

if command -v brave-browser &> /dev/null; then
    echo "Brave browser is already installed"
else
    echo "Installing Brave browser..."
    sudo apt install -y curl
    curl -fsS https://dl.brave.com/install.sh | sh
fi
