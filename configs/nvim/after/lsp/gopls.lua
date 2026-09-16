-- Overrides on top of nvim-lspconfig's gopls config. gopls stopped
-- advertising semantic tokens by default in v0.22.0; turn them back on.
---@type vim.lsp.Config
return {
	settings = {
		gopls = {
			semanticTokens = true,
		},
	},
}
