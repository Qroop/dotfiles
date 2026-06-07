#!/bin/bash

# Make script strict
# e: exit on error
# u: error on undefined variables
# o pipefail: failed command in | counts as failure
set -euo pipefail

# === FLAGS ===
DRY_RUN=false
INSTALL_YAY=false

for arg in "$@"; do
	case $arg in
		-d|--dry-run)	DRY_RUN=true ;;
		--yay)			INSTALL_YAY=true ;;
		*)				echo "Unknown argument: $arg"; exit 1 ;;
	esac
done

# === PATHS ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_LIST="$SCRIPT_DIR/packages/pacman.txt"
AUR_LIST="$SCRIPT_DIR/packages/aur.txt"
BREW_LIST="$SCRIPT_DIR/packages/brew.txt"
BREW_CASK_LIST="$SCRIPT_DIR/packages/brew-cask.txt"
APT_LIST="$SCRIPT_DIR/packages/apt.txt"

# === LOAD HELPERS ===
source "$SCRIPT_DIR/methods.sh"

setup_symlinks () {
	if $DRY_RUN; then 
		$SCRIPT_DIR/setup_symlinks.sh -d
		return
	fi

	$SCRIPT_DIR/setup_symlinks.sh
}


# === MAIN ===
detect_os() {
	unameOut="$(uname -s)"
	case "${unameOut}" in
		Linux*)
			if [ -f /etc/arch-release ]; then
				echo arch
			elif [ -f /etc/debian_version ]; then
				echo debian
			else
				echo linux
			fi
			;;
		Darwin*) echo macos ;;
		*) echo unknown ;;
	esac
}

OS="$(detect_os)"

if [ "$OS" = "arch" ]; then
	install_yay
fi

install_packages
setup_symlinks
