# Emacs configuration
Barebone GNU Emacs configuration, an experiment alongside the Neovim and tmux
setup. See `docs/emacs-migration.md` for intent and plan.

`early-init.el` runs before the GUI starts, `init.el` loads the modules in
`lisp/`, `themes/` holds the custom `lackluster` theme (a port of the
`lackluster-mint` variant used in nvim). Modules are prefixed `init-` to avoid clashing with package names.