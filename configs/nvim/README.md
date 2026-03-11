## Neovim configuration

This directory contains configuration for Neovim, centered around `init.lua`.

### Highlights

- **Plugin management**: Uses `mini.deps` to manage plugins, including `gruvbox.nvim`, `oil.nvim`, `mason.nvim`, `mason-lspconfig`, and `nvim-lspconfig`.
- **Appearance**: Gruvbox-based theme with transparent background and custom highlight groups for floating windows and borders.
- **Editing experience**: Relative line numbers, mouse support, system clipboard integration, break indent, persistent undo, and tuned update/timeout settings.
- **Indentation**: Tab-based indentation (tab width 4) with `expandtab` disabled.
- **LSP**: Mason-managed language servers (e.g. `lua_ls`, `pylsp`) with keymaps for code actions, implementation, references, type definition, rename, and formatting.
- **Mini plugins**: Enables `mini.snippets`, `mini.completion`, `mini.pairs`, `mini.clue`, `mini.pick`, and `mini.notify`.
- **Keymaps**: Leader-based mappings for diagnostics, file and buffer search, window management, and exiting terminal mode.

