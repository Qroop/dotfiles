#!/usr/bin/env bash
# Load OS information
. /etc/os-release

DISTRO_LIKE=$ID_LIKE # debian arch 
LOGFILE="$HOME/install.log"
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export DOTFILES_DIR

echo ">> Installing dependencies..."

case "$DISTRO_LIKE" in
	debian)
        sudo apt update
        sudo apt upgrade -y
	;;
	*)
		echo ">> No known distro detected, exiting..."
	;;
esac

for script in ./install/*.sh; do
    echo ">> Running $script..."
    bash "$script"
done

echo ">> Remember to set your default browser to Brave in Settings -> Default Applications"
