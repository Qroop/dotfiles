# Scripts

Symlinked to `~/.local/scripts`, which is on `PATH` (see `configs/shell/`), so
every executable here can be run from anywhere by name, e.g. `setup_symlinks -d`.

- Drop a new executable (`chmod +x`, no extension) here and it is available
  immediately in new shells.
- `lib/` holds sourced helpers (`methods.sh`) and is not on `PATH`.
- To locate the repo from a script, resolve through the symlink:
    ```bash
    SCRIPT_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    REPO_DIR="$(dirname "$SCRIPT_DIR")"
    ```
