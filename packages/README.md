# Package lists

This directory defines the packages installed by `scripts/dotfiles`. Lists
contain one package name per line; blank lines and lines beginning with `#` are
ignored.

## Files

- **`pacman.txt`**:
  - Official Arch packages, installed via `sudo pacman -S --needed --noconfirm`.

- **`aur.txt`**:
  - AUR packages, installed via `yay -S --needed --noconfirm` when `--yay` is
    supplied.

- **`brew.txt`**: Homebrew formulae, installed with `brew install --formula`.
- **`brew-casks.txt`**: Homebrew casks, installed with `brew install --cask`.

Homebrew must already be installed on macOS, including for a dry run. To change
the package setup, edit the appropriate lists and rerun `scripts/dotfiles`.
