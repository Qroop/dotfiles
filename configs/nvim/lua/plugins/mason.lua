return {
{
	"mason-org/mason.nvim",
	config = function()
	require("mason").setup()
	end,
},
{
	"mason-org/mason-lspconfig.nvim",
	config = function()
	require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"python-lsp-server",
	},
	automatic_installation = false,
	})
	end,
},
}
