## Configuration overview

This directory contains all configuration files that are symlinked into `$HOME` by `install.sh` using the mappings defined in `links.txt`. Each subdirectory corresponds to a specific application or subsystem.

### Layout

- **`nvim/`**: Neovim configuration rooted at `init.lua`, usually linked to `~/.config/nvim`.
- **`shell/`**: Shell configuration such as `.bashrc`, typically linked to `~/.bashrc`.
- **`git/`**: Global Git configuration, linked to `~/.gitconfig`.
- **`i3/`**: i3 window manager configuration and helper scripts, linked to `~/.config/i3`.
- **`i3status/`**: i3status bar configuration, linked to `~/.config/i3status`.
- **`rofi/`**: Rofi launcher theme and behavior, linked to `~/.config/rofi`.
- **`autorandr/`**: Display profiles and hooks for `autorandr`, linked to `~/.config/autorandr`.
- **`gtk-3.0/`**: GTK3 settings and theme configuration, linked to `~/.config/gtk-3.0`.
- **`alacritty/`**: Alacritty terminal configuration, linked to `~/.config/alacritty`.
- **`discord/`**: Discord client settings, linked to `~/.config/discord`.

Adjustments should be made here in the repo; rerunning `install.sh` (or re-running the relevant symlink commands) will propagate changes to the live config via symlinks.

