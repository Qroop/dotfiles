# Package lists

This directory defines the packages that `scripts/install` will install on an Arch Linux system.

## Files

- **`pacman.txt`**:
  - One package name per line.
  - Empty lines and lines beginning with `#` are ignored.
  - Installed via `sudo pacman -S --needed --noconfirm` during `scripts/install`.
  - Intended for packages from the official Arch repositories (core, extra, community, etc.).

- **`aur.txt`**:
  - One package name per line.
  - Empty lines and lines beginning with `#` are ignored.
  - Installed via `yay -S --needed --noconfirm` during `scripts/install`.
  - Intended for packages sourced from the AUR.

To change the base system setup, edit these lists and rerun `scripts/install`.
