#!/bin/bash

# Make script strict
# e: exit on error
# u: error on undefined variables
# o pipefail: failed command in | counts as failure
set -euo pipefail

# === FLAGS ===
DRY_RUN=false
PRUNE=false

for arg in "$@"; do
	case $arg in
		-n|--dry-run)	DRY_RUN=true ;;
		--prune)		PRUNE=true ;;
	*)					echo "Unknown argument: $arg"; exit 1 ;;
	esac
done

# === PATHS ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_LIST="$SCRIPT_DIR/packages/pacman.txt"
AUR_LIST="$SCRIPT_DIR/packages/aur.txt"
LINKS_LIST="$SCRIPT_DIR/links.txt"

# === HELPERS ===
log() {
	echo "[info] $*"; 
}

dry_log() {
	echo "[dry] $*"; 
}

run() {
	if $DRY_RUN; then
		dry_log "$*";
	else
		"$@";
	fi;
}

# === STAGES ===
install_yay() {
	log "Checking yay"; 

	if command -v yay &>/dev/null; then
		log "yay is already installed, skipping"
		return
	fi

	log "yay not found, installing"
	run sudo pacman -S --needed git base-devel
	run git clone https://aur.archlinux.org/yay.git /tmp/yay
	run sh -c "cd /tmp/yay && makepkg -si --noconfirm"
	run rm -rf /tmp/yay
}


install_pacman() {
	log "Installing pacman packages"; 
	packages=()
	while IFS= read -r package; do
		[[ -z "$package" || "$package" == \#* ]] && continue
		packages+=("$package")
	done < "$PACMAN_LIST"

	if [ ${#packages[@]} -eq 0 ]; then
		log "No pacman packages to install, skipping..."
		return
	fi

	run sudo pacman -S --needed --noconfirm "${packages[@]}"
}

install_aur() {
	log "Installing AUR packages"

	packages=()
	while IFS= read -r package; do
		[[ -z "$package" || "$package" == \#* ]] && continue
		packages+=("$package")
	done < "$AUR_LIST"

	if [ ${#packages[@]} -eq 0 ]; then
		log "No AUR packages to install, skipping..."
		return
	fi

	run yay -S --needed --noconfirm "${packages[@]}"
}

prune_pacman() {
	if ! $PRUNE; then
		return
	fi

	log "Pruning pacman packages..."
	packages=()
	while IFS= read -r package; do
		[[ -z "$package" || "$package" == \#* ]] && continue
		packages+=("$package")
	done < "$PACMAN_LIST"

	while IFS= read -r installed; do
		if [[ ! " ${packages[@]} " =~ " $installed " ]]; then
			log "Removing $installed"
			run sudo pacman -Rns --noconfirm "$installed"
		fi
	done < <(pacman -Qqe)
}


setup_symlinks() { log "TODO: setup symlinks"; }

# === MAIN ===
install_yay 
install_pacman
prune_pacman
install_aur 
setup_symlinks
