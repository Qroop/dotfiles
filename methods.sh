# === HELPERS ===
log() {
	echo "[info] $*"; 
}

sub_log() { 
	echo " --> $*"; 
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
		sub_log "yay is already installed, skipping"
		return
	fi

	sub_log "yay not found, installing"
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
		sub_log "No pacman packages to install, skipping..."
		return
	fi

	run sudo pacman -S --needed --noconfirm "${packages[@]}" 2>&1 | grep -v "is up to date"
}

install_aur() {
	if ! $INSTALL_YAY; then
		return
	fi

	log "Installing AUR packages"

	packages=()
	while IFS= read -r package; do
		[[ -z "$package" || "$package" == \#* ]] && continue
		packages+=("$package")
	done < "$AUR_LIST"

	if [ ${#packages[@]} -eq 0 ]; then
		sub_log "No AUR packages to install, skipping..."
		return
	fi

	run yay -S --needed --noconfirm "${packages[@]}"
}

