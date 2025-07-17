#!/usr/bin/env bash
set -e

echo ">> Installing Swedish (Coder) keyboard layout variant..."

SYMBOLS_FILE="/usr/share/X11/xkb/symbols/se"
VARIANT_NAME="coder"
LAYOUT_MARKER="xkb_symbols \"$VARIANT_NAME\""

if ! grep -q "$LAYOUT_MARKER" "$SYMBOLS_FILE"; then
    echo ">> Appending custom variant to $SYMBOLS_FILE..."
    sudo bash -c "cat \"$PWD/../xkb/se-coder.xkb\" >> \"$SYMBOLS_FILE\""
else
    echo ">> Variant already present, skipping patch."
fi

# Optional but useful: update XKB cache
echo ">> Updating xkb-data..."
sudo dpkg-reconfigure xkb-data
setxkbmap se coder

echo ">> Done. Set layout with: setxkbmap se coder"
