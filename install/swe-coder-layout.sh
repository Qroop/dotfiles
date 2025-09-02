#!/usr/bin/env bash

main () {
    set -e

    # Load OS information
    . /etc/os-release

    DISTRO_LIKE=$ID_LIKE # debian arch 
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)

    echo ">> Installing Swedish (Coder) keyboard layout variant"

    SYMBOLS_FILE="/usr/share/X11/xkb/symbols/se"
	echo ">> Symlinking layout"
	sudo rm -f $SYMBOLS_FILE
	sudo ln -s "$DOTFILES_DIR/static/kde-settings/se" $SYMBOLS_FILE
	echo ">> Done symlinking keyboard layout, remember to change to the Swedish US layout"
}

main
