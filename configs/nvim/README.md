# Neovim configuration
Multi-file, minimal, Neovim configuration.

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

- Requires `node` (`nodejs` on Arch) for the Copilot language server.
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
(configured in `lua/markdown.lua`).

- It is enabled for Markdown buffers only.
- It uses the plugin's default modal behavior, so rendered Markdown shows in
  normal mode and the raw text is shown while editing in insert mode.
