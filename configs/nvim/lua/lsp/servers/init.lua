local servers = {
	'lua_ls',
	'gopls',
}

for _, name in ipairs(servers) do
	vim.lsp.config(name, require('lsp.servers.' .. name))
end

require('mason').setup()
require('mason-lspconfig').setup({
	ensure_installed = servers,
})
