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
	require_platform arch "yay installation" || return 1
	log "Checking yay"; 

	if command -v yay &>/dev/null; then
		sub_log "yay is already installed, skipping"
		return
	fi

	sub_log "yay not found, installing"
	run sudo pacman -Syu --needed git base-devel
	run git clone https://aur.archlinux.org/yay.git /tmp/yay
	run sh -c "cd /tmp/yay && makepkg -si --noconfirm"
	run rm -rf /tmp/yay
}


install_pacman() {
	require_platform arch "pacman installation" || return 1
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

	run sudo pacman -S --needed --noconfirm "${packages[@]}" 2>&1 | awk '!/is up to date/'
}


install_aur() {
	require_platform arch "AUR installation" || return 1
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

install_brew_list() {
	require_platform macos "Homebrew installation" || return 1
	local list="$1" kind="$2" package count=0
	local -a packages=()

	if [[ ! -r "$list" ]]; then
		echo "[error] Cannot read Homebrew package list: $list" >&2
		return 1
	fi

	while IFS= read -r package; do
		[[ -z "$package" || "$package" == \#* ]] && continue
		packages+=("$package")
		count=$((count + 1))
	done < "$list"

	if [[ "$count" -eq 0 ]]; then
		sub_log "No Homebrew $kind to install, skipping"
		return
	fi

	run brew install "--$kind" "${packages[@]}"
}

install_brew() {
	require_platform macos "Homebrew installation" || return 1

	if ! command -v brew &>/dev/null; then
		echo "[error] Homebrew is required; install it from https://brew.sh/ and try again" >&2
		return 1
	fi

	log "Installing Homebrew packages"
	install_brew_list "$BREW_LIST" formula || return 1
	install_brew_list "$BREW_CASK_LIST" cask
}
