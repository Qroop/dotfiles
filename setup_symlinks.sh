#!/bin/bash

# Make script strict
# e: exit on error
# u: error on undefined variables
# o pipefail: failed command in | counts as failure
set -euo pipefail

# === FLAGS ===
DRY_RUN=false

for arg in "$@"; do
	case $arg in
		-d|--dry-run)	DRY_RUN=true ;;
	esac
done

# === PATHS ===
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LINKS_FILE="$SCRIPT_DIR/links.txt"

# === HELPERS ===
source "$SCRIPT_DIR/methods.sh"

setup_symlinks() {
	log "Setting up symlinks"
	while IFS= read -r line; do
		[[ -z "$line" || "$line" == \#* ]] && continue

		source=$(echo "$line" | awk '{print $1}')
		target=$(echo "$line" | awk '{print $2}')
		source="$SCRIPT_DIR/$source"
		target="${target/#\~/$HOME}"

		if [[ -e "$target" && ! -L "$target" ]]; then
			if [[ ! -e "$source" ]]; then
				sub_log "Adopting $target into repo"
				run mkdir -p "$(dirname "$source")"
				run cp -r "$target" "$source"
				run rm -rf "$target"
			else
				sub_log "$target already exists in repo, replacing with symlink"
				run rm -rf "$target"
			fi
		fi

		if [[ -L "$target" && "$(readlink "$target")" == "$source" ]]; then
			sub_log "Skipping $target, already symlinked"
			continue
		fi

		sub_log "Linking $source -> $target"
		run mkdir -p "$(dirname "$target")"
		run ln -sf "$source" "$target"
	done < "$LINKS_FILE"
}

setup_symlinks
