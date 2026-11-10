# Trying out Emacs

## Intent

Try Emacs as a daily editor and see whether it sticks.

**This is an experiment, not a replacement.** The Neovim config
(`configs/nvim`) and the tmux config (`configs/tmux`, `configs/tmux-sessionizer`)
stay in the repo, stay linked and stay working the whole time. Nothing in them
should be deleted, trimmed or "migrated away" as part of this. If Emacs doesn't
work out, moving back should cost nothing: keep using `nvim` and tmux as today.
Any removal of the old setup is a separate decision for much later, and only
if Emacs has clearly won.

Practical consequences:

- Emacs gets its own `configs/emacs/` and its own `links.txt` line. No existing
  line or file is changed to make room for it.
- `EDITOR`, `MANPAGER` and the shell config stay pointed at `nvim` until a
  deliberate decision says otherwise.
- Package list entries for Emacs are purely additive.

## Why

- Emacs is a graphical editor. Terminal Emacs would give up most of the benefit,
  so the plan is GUI Emacs.
- Vim bindings are non-negotiable (no "Emacs pinky"). Evil mode provides them.
- Barebone is the preference: no Doom/Spacemacs, just a hand-written config of
  roughly the same size and spirit as the nvim one.

## Decisions

| Topic | Decision |
| --- | --- |
| Distribution | None. Plain GNU Emacs 30+ with `use-package` (built in). |
| Vim bindings | Evil + evil-collection + evil-commentary, `SPC` as leader. |
| Frontend | GUI only, running as a daemon (`emacsclient -c`). |
| tmux | Not used while working in Emacs. Emacs windows replace panes, tab-bar tabs replace tmux sessions/windows, `project.el` replaces the sessionizer. tmux itself stays installed and configured. |
| Workspaces | The core thing to keep from tmux: separate, self-contained workspaces per project, each with its own layout (editor, terminal, whatever was open), so switching project and back restores exactly how it was left. Built with `project.el` + built-in `tab-bar` (one tab per project). `tabspaces` is an optional later upgrade, see below. |
| Project choice | Any directory, not just the sessionizer's configured paths. A new workspace starts empty: no default tabs, files or terminal are opened automatically. |
| Theme | Basic dark theme: the built-in `modus-vivendi`. |
| Font | GeistMono Nerd Font, matching Alacritty. |
| Keybindings | One keymap instead of two: everything under `SPC` (e.g. `SPC \|` / `SPC -` split windows, whereas today nvim uses `<leader>\|` and tmux uses `C-f \|`). A few global `M-` keys (window movement, tab selection) so they work in insert mode and terminal buffers too. |
| Scope | Not everything has to be ported. Skipped on purpose: the Claude status dot, the sessionizer's fzf preview, the filtered workspace-symbol pickers (`<leader>fc/fp/fv`), the man page and Git changed-files pickers, snippets, tab-out of closing pairs. Add later only if missed. |
| Language modes | `go-mode`, `lua-mode`, `csharp-mode` (no tree-sitter grammars to compile). |
| Platforms | Must work on macOS (current machine, Homebrew) and Arch (pacman). |

## How the current setup maps over

| Today (nvim / tmux) | Emacs |
| --- | --- |
| `vim.pack` + lockfile | `package.el` + `use-package :ensure` (no lockfile) |
| mini.pick (`<leader>f*`) | vertico + orderless + consult + marginalia |
| blink.cmp | corfu + cape |
| mason + lspconfig | eglot; servers from brew/pacman (`gopls`, `lua-language-server`) and `dotnet tool install -g csharp-ls` |
| conform (goimports, gofumpt) | `eglot-format` + organize-imports code action, gopls `gofumpt` setting |
| `gd gi gt gr ga gn gf go gO K` | same keys, bound to eglot/xref/consult equivalents; `C-o` keeps working via `evil-set-jump` advice |
| oil.nvim | dired (+ wdired to rename by editing) |
| mini.diff, oil-git-status | diff-hl; magit for everything else git |
| mini.clue | which-key |
| mini.pairs | `electric-pair-mode` |
| render-markdown | `markdown-mode` (less pretty, skipped at first) |
| `<C-c>` -> `:make` | `SPC c c` -> `project-compile` without a prompt, `compile-command` set per mode |
| `checktime` autocmd | `global-auto-revert-mode` |
| `undofile`, `swapfile=false` | no backups/lockfiles; `vundo` for the undo tree (persistent undo not ported) |
| tmux panes (`M-h/j/k/l`, `C-f \|`) | Emacs windows (`C-w`, `SPC w`, global `M-h/j/k/l`) |
| tmux sessions / windows (`M-1..9`) | tab-bar tabs, one per project, each remembering its own window layout (`M-1..9`) |
| tmux-sessionizer (`C-a`) | `SPC p p`: jump to an open workspace, or pick any directory to open a new empty one. A directory search over `~` (like `fcd`'s `find ~ -maxdepth 5`) can feed the same prompt. |
| scratch terminal (`M-t`) | `SPC t t`, an `eat` terminal in a bottom window |
| Claude Code in a pane | run `claude` in the `eat` terminal |

## Recommended path

Do these in order and stop whenever it stops being fun. Each step leaves nvim
and tmux fully usable.

1. **Install.** Add the `emacs` cask (macOS, already in `packages/brew-casks.txt`)
   or the `emacs` package (Arch). Also `ripgrep`, `fd`, `gopls` and
   `lua-language-server`. Check on Arch whether the `emacs` package is the
   Wayland-native (pgtk) build or whether a different package is needed; this
   wasn't verified.
2. **Scaffold the config** in `configs/emacs/` with `early-init.el`, `init.el`
   and small modules in `lisp/` (see layout below), a short `README.md`, and
   a `links.txt` line `configs/emacs ~/.config/emacs`. Validate the link with
   `./scripts/setup_symlinks -d`. Remove any `~/.emacs` or `~/.emacs.d`, which
   would take precedence over the XDG directory.
3. **Core feel first.** Evil, evil-collection, which-key, vertico/consult, the
   theme and font, relative line numbers, scroll margin, tabs (width 4),
   auto-revert, and the `SPC f*` finders. Get comfortable editing before adding
   anything else.
4. **LSP for Go**, then Lua, then C#. Verify `gd`, `gr`, `gn`, `gf` and `C-o`.
   Test C# on a real project early, since it is the least polished.
5. **magit and dired.** Magit is the biggest reason to switch. Learn
   `SPC g g` first.
6. **Windows, tabs and workspaces.** `project.el` + `tab-bar`, a switcher that
   jumps to an open workspace or opens any directory in a new empty tab, the
   terminal toggle and the global `M-` keys. This is what lets tmux be left
   alone. See "Workspaces" below.
7. **Daemon.** Arch: `systemctl --user enable --now emacs`. macOS:
   `emacs --daemon`, or just keep Emacs.app open (the config can start the
   server itself). Open frames with `emacsclient -c -a ""`, bound to a global
   shortcut.
8. **Use it for real for a week or two**, with nvim and tmux as the fallback.
   Write down what annoys you, then decide.

Only after that: consider switching `EDITOR`/`MANPAGER`, or retiring parts of
the old setup. Neither is required to keep using Emacs.

## Workspaces

The goal: work in one project with an editor and a terminal laid out how I
like, switch to another project with a completely separate setup, and come
back to find the first one untouched.

- **`project.el` alone is not enough.** It scopes commands (find file, grep,
  compile, `project-switch-to-buffer`, `project-kill-buffers`) to a project
  root, but it has no memory of window layout, and the buffer pool is global.
- **`tab-bar` (built in) provides the layout part.** One tab per project; each
  tab keeps its own windows and splits. Switching tabs restores the
  arrangement exactly. No extra package needed.
- **Start with just those two.** `SPC p b` (`project-switch-to-buffer`) already
  gives project-scoped buffer lists. The global `SPC b b` still shows every
  buffer, which is mildly messy but acceptable.
- **Optional upgrade: `tabspaces`.** Scopes each tab's buffer list to that
  workspace (so other projects' buffers disappear from `SPC b b`) and can
  restore workspaces across a full Emacs restart. Add it only if the shared
  buffer list becomes annoying; it slots in without changing the rest.
  Alternatives: `bufferlo`, `perspective`. These were described from general
  knowledge and not tried, so read each README before choosing.
- **Switcher behaviour.** `SPC p p` lists open workspaces first. Picking one
  jumps to its tab. Picking or typing any other directory creates a new tab
  named after it, with no files or terminal opened. `project.el` only
  recognises VCS roots by default, so non-repo directories need a small bit of
  custom code that treats the directory itself as the root.
- **Shared on purpose:** kill-ring, registers, minibuffer history and config.
- **Persistence:** with the daemon running, workspaces survive closing frames,
  like detaching from tmux. Surviving a full restart needs `tabspaces` or
  `desktop-save-mode`.
- **Rejected:** one Emacs daemon per project (fully isolated but heavy, and
  nothing is shared), and one frame per project (frames still share buffers).

## Suggested config layout

Mirrors the nvim config: a thin `init.el` that loads modules, with
state kept out of the repo.

```
configs/emacs/
  early-init.el        state/cache dirs, frame defaults, native-comp cache
  init.el              load-path + requires + server start
  README.md
  lisp/
    init-packages.el   package.el, use-package, exec-path-from-shell
    init-options.el    editor options, macOS modifiers
    init-theme.el      font + modus-vivendi
    init-evil.el       evil, evil-collection, evil-commentary, vundo
    init-completion.el vertico, orderless, marginalia, consult, corfu, cape
    init-languages.el  eglot, go/lua/csharp modes, format + build commands
    init-git.el        magit, diff-hl
    init-files.el      dired
    init-terminal.el   eat + toggle
    init-windows.el    tab-bar, project.el, workspace switcher (any directory)
    init-keymaps.el    which-key, general, leader and g bindings
```

Module names are prefixed `init-` because Elisp features share one global
namespace (a module called `evil` would clash with the package).

Packages, history, project list and the native-comp cache should be redirected
to `~/.local/share|state|cache/emacs` so nothing is written into the repo.

## Platform notes

- **macOS:** left Option as Meta and right Option left alone (mirrors Alacritty's
  `option_as_alt = "OnlyLeft"`), so `@`, `|` and similar still type on a Swedish
  keyboard. GUI apps don't inherit the shell `PATH`, so use
  `exec-path-from-shell` (with `-l -i`, since `PATH` is set in `~/.variables` via
  the interactive rc files). BSD `ls` has no `--group-directories-first`, so
  the dired switches need a platform check.
- **Arch:** the systemd user service doesn't see the shell `PATH` either, so
  the same `exec-path-from-shell` setup applies. KDE shortcut for
  `emacsclient -c -a ""`.

## Known risks / things to verify

- A first draft of the config was written from memory without being run, so
  expect to debug on first launch. Most likely trouble spots:
  - corfu `RET` handling (accept only an explicitly selected candidate,
    otherwise newline),
  - general.el `:wk` prefix labels,
  - the eat terminal toggle and its `display-buffer-alist` rule,
  - dired `ls` switches per platform,
  - the workspace switcher (any directory, open-tab detection, empty new tabs),
  - `use-package` behaviour with built-in packages (`eglot`, `project`, `which-key`).
- Evil in special buffers (magit, eat, compilation) relies on evil-collection
  and has some "why doesn't `q` do X here" moments.
- Elisp, unlike Lua, will be needed for the odd custom bit (the Go/C# build
  commands, the project switcher).
- No package lockfile: versions float with MELPA unless a tool such as
  `straight.el` is added later.
- Terminal Emacs is deliberately not a goal; if a remote or SSH workflow ever
  needs it, nvim is still there for that.
