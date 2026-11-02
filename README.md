# Dotfiles
These dotfiles configure a desktop, including the terminal, editor, and a small
set of core tools. The installation script supports Arch Linux and its
derivatives, and macOS with Homebrew.

## Usage
- **Install packages and create symbolic links:**
    ```bash
    ./scripts/dotfiles
    ```
- **Include AUR packages on Arch:** Install yay if needed, then install packages
  from the AUR list.
    ```bash
    ./scripts/dotfiles --yay
    ```
- **Dry run:** Display commands without making changes.
    ```bash
    ./scripts/dotfiles -d
    ```
- **Setup symlinks:** Symbolic links can be set up on their own
  without also installing all the packages. This script can also
  be run dry. Runnable from anywhere once installed (see `scripts/`).
    ```bash
    setup_symlinks [-d]
    ```

On macOS, install [Homebrew](https://brew.sh/) first; it is required even for a
dry run. `--yay` is only supported on Arch and its derivatives. On other
systems, package installation is skipped and symlinks are still set up.
