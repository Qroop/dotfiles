#!/usr/bin/env bash

main() {
    DOTFILES_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
	rm "$HOME/.config/kglobalshortcutsrc"
	ln -s "$DOTFILES_DIR/.config/kglobalshortcutsrc" "$HOME/.config/kglobalshortcutsrc"
}

main
