# Emacs configuration
Barebone GNU Emacs configuration, an experiment alongside the Neovim and tmux
setup. See `docs/emacs-migration.md` for intent and plan.

`early-init.el` runs before the GUI starts, `init.el` loads the modules in
`lisp/`, `themes/` holds the custom `lackluster` theme (a port of the
`lackluster-mint` variant used in nvim). Modules are prefixed `init-` to avoid clashing with package names.

## Keys

`SPC` is the leader key in normal, visual and motion state (which-key shows the
options after a short delay).

| Key | Action |
| --- | --- |
| `SPC SPC` | `M-x` |
| `SPC f f` | Find file in the current project |
| `SPC f g` | Live ripgrep in the current project |
| `C-a` / `SPC p p` | Switch project (known projects, `~/Projects`, `~/Forefront`, `~/dotfiles`) |
| `SPC s` | Reload `init.el` and all modules |
| `C-j` / `C-k` | Next / previous candidate in vertico |

The project switcher only works for directories project.el recognises, which
means git repositories for now.
