local formatters_by_ft = {
	lua = { 'stylua' },
	go = { 'goimports', 'gofumpt' },
	cs = { 'clang-format' },
}

local tools = { 'copilot-language-server' }
for _, filetype_formatters in pairs(formatters_by_ft) do
	vim.list_extend(tools, filetype_formatters)
end

require('mason-tool-installer').setup({
	ensure_installed = tools,
})

require('conform').setup({
	formatters_by_ft = formatters_by_ft,
	default_format_opts = {
		lsp_format = 'fallback',
	},
})
