# Scripts

Symlinked to `~/.local/scripts`, which is on `PATH` (see `configs/shell/`), so
every executable here can be run from anywhere by name, e.g. `setup_symlinks -d`.

- Drop a new executable (`chmod +x`, no extension) here and it is available
  immediately in new shells.
- `lib/` holds sourced helpers, including platform detection, and is not on
  `PATH`.
- `dotfiles` installs packages for Arch Linux or macOS and sets up symlinks.
  Use `-d` for a dry run and `--yay` to include AUR packages on Arch.
- `fbranch` fuzzy-finds local and remote Git branches with `fzf`, then switches
  to the selected branch (creating a local tracking branch for a remote-only
  selection).
- To locate the repo from a script, resolve through the symlink:
    ```bash
    SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    REPO_DIR="$(dirname "$SCRIPT_DIR")"
    ```
