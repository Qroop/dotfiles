-- LSP: everything is driven by Mason, which downloads the servers and puts
-- them on $PATH, so no language server has to be installed by hand.
-- nvim-lspconfig supplies the base config (cmd, filetypes, root markers) for
-- each server; per-server tweaks live in `after/lsp/<server>.lua`.
vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
	"https://github.com/stevearc/conform.nvim",
})

require('mason').setup()

-- mason-lspconfig installs anything missing from `ensure_installed` and
-- enables every installed server, so an explicit `vim.lsp.enable` list is not
-- needed: adding a server here is enough.
require('mason-lspconfig').setup({
	ensure_installed = { 'lua_ls', 'gopls', 'csharp_ls' },
})

-- Everything Mason installs that is not an LSP server: formatters and the
-- Copilot language server used by copilot.lua (see lua/completion.lua).
require('mason-tool-installer').setup({
	ensure_installed = {
		'stylua',
		'gofumpt',
		'goimports',
		'copilot-language-server',
		'clang-format',
	},
})

-- Formatting (`gf`, see lua/keymaps.lua) goes through conform, which runs the
-- Mason-installed formatters below. Filetypes without an entry fall back to
-- the language server's own formatter.
require('conform').setup({
	formatters_by_ft = {
		lua = { 'stylua' },
		go = { 'goimports', 'gofumpt' },
		cs = { 'clang-format' },
	},
	default_format_opts = {
		lsp_format = 'fallback',
	},
})

vim.diagnostic.config({ virtual_text = true })
