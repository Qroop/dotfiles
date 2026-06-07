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


install_brew_packages() {
	log "Installing Homebrew packages"

	if ! command -v brew >/dev/null 2>&1; then
		sub_log "Homebrew not found, please install Homebrew and re-run (https://brew.sh/)"
		return
	fi

	packages=()
	if [ -f "$BREW_LIST" ]; then
		while IFS= read -r package; do
			[[ -z "$package" || "$package" == \#* ]] && continue
			packages+=("$package")
		done < "$BREW_LIST"
	fi

	if [ ${#packages[@]} -eq 0 ]; then
		sub_log "No brew packages to install, skipping..."
	else
		run brew install "${packages[@]}"
	fi

	# Optional casks
	casks=()
	if [ -f "$BREW_CASK_LIST" ]; then
		while IFS= read -r cask; do
			[[ -z "$cask" || "$cask" == \#* ]] && continue
			casks+=("$cask")
		done < "$BREW_CASK_LIST"
	fi

	if [ ${#casks[@]} -ne 0 ]; then
		run brew install --cask "${casks[@]}"
	fi
}

install_apt_packages() {
	log "Installing apt packages"

	packages=()
	if [ -f "$APT_LIST" ]; then
		while IFS= read -r package; do
			[[ -z "$package" || "$package" == \#* ]] && continue
			packages+=("$package")
		done < "$APT_LIST"
	fi

	if [ ${#packages[@]} -eq 0 ]; then
		sub_log "No apt packages to install, skipping..."
		return
	fi

	run sudo apt update
	run sudo apt install -y "${packages[@]}"
}

install_packages() {
	case "${OS:-}" in
		arch)
			install_pacman
			;;
		macos)
			install_brew_packages
			;;
		debian|ubuntu)
			install_apt_packages
			;;
		*)
			log "Unknown or unsupported OS ('${OS:-unknown}'), skipping package installation"
			;;
	esac
}

