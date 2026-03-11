## i3 window manager configuration

This directory contains configuration for the i3 window manager and related helper scripts.

### Files

- **`config`**:
  - Main i3 configuration file.
  - Defines keybindings, workspace layout, gaps, borders, colors, and startup applications.
  - Binds `$mod+Return` to `alacritty`, `$mod+d` to `rofi -show drun`, and includes bindings for volume/media keys.
  - Starts compositing (`picom`), `xss-lock` with `i3lock`, `nm-applet`, `blueman-applet`, and other tray/background services.
  - Sets the wallpaper using `feh` and references `~/dotfiles/static/wallpaper.png`.
  - Integrates with `i3status` and the `i3-keyboard-layout` script to show keyboard layout in the bar.

- **`i3-keyboard-layout`**:
  - Helper script used to cycle keyboard layouts and to post-process `i3status` output.
  - Referenced from the main `config` for layout switching and status bar customization.

