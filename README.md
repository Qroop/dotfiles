## Dotfiles for Arch Linux

These dotfiles configure an i3-based Arch Linux desktop, including the terminal, editor, window manager, theming, and a small set of core tools. The repo also contains a reproducible package set and an installation script that bootstraps a new machine.

### Target system and assumptions

- **Distro**: Arch Linux (or a close Arch derivative using `pacman` and compatible AUR tooling).
- **Privileges**: A user with `sudo` access (for installing packages and creating system-level symlinks).
- **Network**: Required for installing packages from the official repos and the AUR.

### Installation overview

The `install.sh` script is the entry point for setting up a system:

- **Installs `yay`** if it is not already present.
- **Installs `pacman` packages** listed in `packages/pacman.txt`.
- **Optionally prunes packages** that are installed but not listed in `packages/pacman.txt`.
- **Optionally installs AUR packages** listed in `packages/aur.txt` using `yay`.
- **Creates symlinks** for configuration files as defined in `links.txt`, adopting existing configs into the repo where appropriate.
- **Optionally replaces `dmenu` with `rofi`** by creating a symlink at `/usr/local/bin/dmenu` pointing to `/usr/bin/rofi`.

You can run the script in a dry-run mode first to see what would change without actually modifying the system.

#### Basic usage

- **Dry run (no changes, just log commands):**

```bash
./install.sh -n
```

- **Pacman installation (no pruning):**

```bash
./install.sh
```

- **Pacman installation with package pruning:**

```bash
./install.sh --prune
```

- **Full installattion:**

```bash
./install.sh --yay
```

Flags:

- **`-n`, `--dry-run`**: Print what would be done instead of executing it.
- **`--prune`**: After installing packages from `packages/pacman.txt`, remove any explicitly installed packages that are not in that list.
- **`--yay`**: Install AUR packages in `packages/aur.txt`.

### Package lists

- **`packages/pacman.txt`**: Packages installed from the official Arch repositories. Empty lines and lines starting with `#` are ignored. This list covers:
  - Terminal and editor tooling (e.g. `alacritty`, `tmux`, `neovim`).
  - Core system utilities and common applications.
  - i3 window manager and related desktop tooling.
- **`packages/aur.txt`**: Packages installed from the AUR using `yay`. As with the `pacman` list, comments and empty lines are ignored.

Keeping these files up to date controls which packages a new system will receive.

### Symlink management

Symlinks are defined in `links.txt`. Each non-comment line is of the form:

```text
<repo-path>    <target-path>
```

- `<repo-path>` is a path relative to the repository root (e.g. `configs/nvim`).
- `<target-path>` is the absolute path under `$HOME` where the configuration should live (e.g. `~/.config/nvim`).

When `install.sh` runs:

- If a **regular file or directory already exists at the target path** but not in the repo, it is:
  - Copied into the repo under `<repo-path>`.
  - Removed from the original location.
  - Replaced with a symlink pointing back into the repo.
- If the **target is already a symlink** pointing to the correct `<repo-path>`, it is left unchanged.
- Otherwise, the script creates or updates a symlink so that the target points into this repository.

### Repository structure

- **`install.sh`**: Main setup script. Installs packages, manages pruning, creates symlinks, and optionally replaces `dmenu` with `rofi`.
- **`links.txt`**: Mapping between paths inside this repo and their destinations in your home directory.
- **`packages/`**:
  - **`pacman.txt`**: Official repository packages to install.
  - **`aur.txt`**: AUR packages to install via `yay`.
- **`configs/`**: All configuration files that will be symlinked into `$HOME`. Key subdirectories:
  - **`nvim/`**: Neovim configuration (`init.lua`).
  - **`shell/`**: Shell configuration, including `.bashrc`.
  - **`git/`**: Git configuration (global `.gitconfig`).
  - **`i3/`**: i3 window manager configuration and helper scripts.
  - **`i3status/`**: Status bar configuration for i3.
  - **`rofi/`**: Rofi launcher configuration.
  - **`autorandr/`**: Display profile configuration and hooks.
  - **`gtk-3.0/`**: GTK theming and toolkit settings.
  - **`alacritty/`**: Alacritty terminal configuration.
  - **`discord/`**: Discord client settings.

See the `README.md` files in `configs/`, `packages/`, and each config subdirectory for more detail on what each component configures.

