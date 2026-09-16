# Neovim configuration
Multi-file, minimal, Neovim configuration.

## LSP

All language tooling is managed by [mason.nvim](https://github.com/mason-org/mason.nvim)
from inside Neovim, so nothing has to be installed through pacman/brew/`dotnet
tool` by hand. Everything lives in `lua/lsp.lua`: plugin installation, Mason,
the server list, extra tools and formatting.

| Plugin | Role |
| --- | --- |
| [mason.nvim](https://github.com/mason-org/mason.nvim) | Downloads servers/tools and puts them on `$PATH` |
| [mason-lspconfig.nvim](https://github.com/mason-org/mason-lspconfig.nvim) | Installs `ensure_installed` servers and enables every installed one |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) | Base config (`cmd`, `filetypes`, root markers) per server |
| [mason-tool-installer.nvim](https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim) | Non-LSP tools (formatters, the Copilot server) |
| [conform.nvim](https://github.com/stevearc/conform.nvim) | Runs the formatters |

Installed servers: `lua_ls`, `gopls`, `csharp_ls`.
Installed tools: `stylua`, `gofumpt`, `goimports`, `copilot-language-server`.

Per-server tweaks go in `after/lsp/<server>.lua` and are merged on top of
nvim-lspconfig's defaults — only the overrides belong there, not a full config.
There is one for `lua_ls` (codelens + inlay hints) and one for `gopls`
(semantic tokens); `csharp_ls` uses the defaults as-is.

### Adding a language

1. Add the server name to `ensure_installed` in `lua/lsp.lua`.
2. Optionally create `after/lsp/<server>.lua` returning a table of overrides.
3. Optionally add a formatter to `ensure_installed` in the
   `mason-tool-installer` block and map it in `formatters_by_ft`.

Restart Neovim and Mason installs whatever is missing.

### Commands

| Command | Action |
| --- | --- |
| `:Mason` | Installer UI — see what is installed, install/update/remove |
| `:MasonToolsUpdate` | Update the tools from `mason-tool-installer` |
| `:ConformInfo` | Which formatters apply to the current buffer |
| `:checkhealth mason` | Check Mason's own prerequisites |

Mason only downloads the servers; the runtimes they need must exist on the
system (a Go toolchain for `gopls`, the .NET SDK for `csharp_ls`).

## Building

`<C-c>` runs `:make`. In C# buffers this invokes `dotnet build`, parses
file/line/column diagnostics into the quickfix list, and jumps to the first
compiler error. Use `:cnext` and `:cprevious` to move between errors.

## Formatting

`gf` formats the buffer (or selection in visual mode) through conform:
`stylua` for Lua, `goimports` + `gofumpt` for Go. Filetypes without a
configured formatter fall back to the language server's own formatter, so `gf`
keeps working everywhere.

## Completion

Completion is handled by [blink.cmp](https://github.com/Saghen/blink.cmp)
(configured in `lua/completion.lua`), which merges these sources into a single
menu:

- **LSP** — from the servers enabled in `lua/lsp.lua`
- **Snippets** — Neovim's built-in `vim.snippet` engine with the
  [friendly-snippets](https://github.com/rafamadriz/friendly-snippets) collection
- **Path** and **buffer** words
- **GitHub Copilot** — via
  [copilot.lua](https://github.com/zbirenbaum/copilot.lua) (backend only, inline
  suggestions disabled) and
  [blink-copilot](https://github.com/fang2hou/blink-copilot)

### Keys

| Key | Action |
| --- | --- |
| _(automatic)_ | The menu opens as you type |
| `<C-j>` / `<C-k>` | Select next / previous item |
| `<CR>` | Accept the selected item (plain newline if nothing is selected) |
| `<Tab>` | Jump to next snippet placeholder, otherwise tab out of a closing pair (`)`, `]`, `}`, `"`, `'`), otherwise insert a tab |
| `<S-Tab>` | Jump to previous snippet placeholder |
| `<C-space>` | Open menu / toggle documentation |
| `<C-e>` | Hide the menu |
| `<C-b>` / `<C-f>` | Scroll the documentation window |

### Setup

- The Copilot language server is installed by Mason (see above); `node`
  (`nodejs` on Arch) is still required to run it.
- Run `:Copilot auth` once per machine to sign in, and `:Copilot status` to
  check the connection.
- blink.cmp is pinned to the `1.*` release range so `vim.pack` checks out a tag,
  which lets blink download its prebuilt Rust fuzzy matcher. If the download
  fails it falls back to the Lua matcher with a warning; `:checkhealth blink`
  shows which one is in use.

## Tabout

[neotab.nvim](https://github.com/kawre/neotab.nvim) (set up in
`lua/plugins.lua`) moves the cursor past a closing quote/bracket when `<Tab>` is
pressed next to one. It is configured with an empty `tabkey`, so `<Tab>` stays
owned by blink.cmp, which calls `require('neotab').tabout()` after trying a
snippet jump. `mini.pairs` still inserts the closing character; neotab only
jumps over it.

## Markdown

Markdown rendering is handled by
[render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim)
(configured in `lua/plugins.lua`).

- It is enabled for Markdown buffers only.
- It uses the plugin's default modal behavior, so rendered Markdown shows in
  normal mode and the raw text is shown while editing in insert mode.
