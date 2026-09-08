# Copilot instructions for this repo

This is a personal dotfiles repo for an Arch Linux desktop (terminal, editor,
shell, tmux, git, ssh, KDE keybindings). There is no build/test/lint tooling —
validation is done by running the scripts, typically with `-d`/`--dry-run`.

## Working agreement

- **Never commit or push changes on your own initiative, including in
  autopilot/background modes.** Always ask first and wait for explicit
  confirmation before running `git commit`, `git push`, or similar. The user
  prefers to test changes thoroughly themselves before anything is committed.

## Running / validating changes

- `./install.sh -d` — dry run of the full install (packages + symlinks); shows
  every command that would run, without executing it.
- `./install.sh --yay` — full install: installs yay (if missing), pacman
  packages, AUR packages, then sets up symlinks.
- `./setup_symlinks.sh -d` / `./setup_symlinks.sh` — symlink step on its own,
  dry-run or real. Use this to validate changes to `links.txt` without
  touching packages.
- All scripts use `set -euo pipefail`; keep new/edited scripts consistent
  with that (fail fast, no unset vars, pipe failures propagate).

There are no automated tests. When changing `install.sh`, `setup_symlinks.sh`,
or `methods.sh`, verify by running the relevant script with `-d` and reading
the dry-run output for correctness.

## Architecture

- `install.sh` is the entrypoint: sources `methods.sh` for shared helpers
  (`log`, `sub_log`, `dry_log`, `run`, `install_yay`, `install_pacman`,
  `install_aur`), then calls `setup_symlinks.sh`.
- `methods.sh`'s `run()` wrapper is the dry-run mechanism: every
  destructive/system command in these scripts should be invoked via
  `run <cmd>` rather than called directly, so `-d`/`--dry-run` can no-op it.
- `packages/pacman.txt` and `packages/aur.txt` are plain package-name lists
  (one per line, `#` comments and blank lines ignored) consumed by
  `install_pacman`/`install_aur` in `methods.sh`.
- `links.txt` drives `setup_symlinks.sh`: each non-comment line is
  `<source relative to repo root> <target path, ~ expands to $HOME>`,
  whitespace-separated. `setup_symlinks.sh` reads it line by line and for
  each entry:
  - if the target exists as a real file/dir (not a symlink) and no source
    exists yet in the repo, it *adopts* the target into the repo (copies it
    to `source`, removes the original) — this is how new configs get added.
  - if the target exists and a source already exists, the target is replaced
    with a symlink to the repo's copy.
  - if already correctly symlinked, it's skipped.
  - otherwise it creates parent dirs and symlinks target -> source.
- `configs/<tool>/` holds the actual dotfiles per application, each with its
  own short `README.md`. Add new tool configs there and add a corresponding
  line to `links.txt`.

## Conventions

- Every subdirectory (`configs/`, `packages/`, and each `configs/<tool>/`)
  has a short `README.md` describing its purpose — add/update one when
  introducing a new config directory.
- Package lists and `links.txt` use `#` for comments and blank lines for
  spacing; keep new entries in that same simple format.
- Tabs are used for indentation in the shell scripts (`install.sh`,
  `setup_symlinks.sh`, `methods.sh`) — match existing style in those files.
- Neovim config (`configs/nvim/`) is a multi-file, minimal setup: `init.lua`
  loads modules under `lua/` (`options`, `keymaps`, `autocommands`,
  `colorscheme`, `plugins`, `lsp`), with per-server LSP settings split out
  under `lsp/` (e.g. `lsp/gopls.lua`, `lsp/lua_ls.lua`).
