## Autorandr configuration

This directory defines display profiles and hooks for `autorandr`.

### Files and profiles

- **`single/`**:
  - `config` and `setup` describe a single-display layout.
- **`dual/`**:
  - `config` and `setup` describe a dual-display layout.
- **`postswitch`**:
  - Shell script executed after `autorandr` switches profiles.
  - Currently sets the wallpaper via `feh` using `~/dotfiles/static/wallpaper.png`.

