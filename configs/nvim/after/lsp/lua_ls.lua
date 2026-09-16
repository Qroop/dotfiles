-- Overrides on top of nvim-lspconfig's lua_ls config.
---@type vim.lsp.Config
return {
	settings = {
		Lua = {
			codeLens = { enable = true },
			hint = { enable = true, semicolon = 'Disable' },
		},
	},
}
