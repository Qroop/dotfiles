## Package lists

This directory defines the packages that `install.sh` will install on an Arch Linux system.

### Files

- **`pacman.txt`**:
  - One package name per line.
  - Empty lines and lines beginning with `#` are ignored.
  - Installed via `sudo pacman -S --needed --noconfirm` during `install.sh`.
  - Intended for packages from the official Arch repositories (core, extra, community, etc.).

- **`aur.txt`**:
  - One package name per line.
  - Empty lines and lines beginning with `#` are ignored.
  - Installed via `yay -S --needed --noconfirm` during `install.sh`.
  - Intended for packages sourced from the AUR.

To change the base system setup, edit these lists and rerun `install.sh`. Use the `--prune` flag if you want to remove explicitly installed packages that are no longer listed in `pacman.txt`.

