#!/usr/bin/env bash
# Copies stdin to the system clipboard, picking the right tool for the platform:
# macOS (pbcopy), Wayland (wl-copy), X11 (xclip).
set -euo pipefail

if command -v pbcopy >/dev/null 2>&1; then
	exec pbcopy
elif [[ -n "${WAYLAND_DISPLAY:-}" ]] && command -v wl-copy >/dev/null 2>&1; then
	exec wl-copy
elif command -v xclip >/dev/null 2>&1; then
	exec xclip -selection clipboard -in
else
	echo "tmux-clipboard: no clipboard tool found (pbcopy/wl-copy/xclip)" >&2
	exit 1
fi
