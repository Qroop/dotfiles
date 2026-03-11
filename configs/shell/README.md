## Shell configuration

This directory contains shell-related configuration files.

### Files

- **`.bashrc`**:
  - Sets the default editor (`EDITOR`) to `nvim`.
  - Uses Neovim as `MANPAGER`.
  - Sets `TERMINAL` to `alacritty` and `BROWSER` to `brave`.
  - Adds colorized aliases for `ls` and `grep`.
  - Defines a simple `PS1` prompt of the form `[user@host cwd]$`.
  - Exits early when the shell is non-interactive (`[[ $- != *i* ]] && return`).

