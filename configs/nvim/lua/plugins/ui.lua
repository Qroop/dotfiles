require('mini.icons').setup()

require('nvim-treesitter').install({
	'markdown', 'markdown_inline', 'html', 'latex', 'yaml',
	'lua', 'bash', 'go', 'json', 'vim', 'vimdoc',
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = { 'markdown' },
	callback = function()
		vim.treesitter.start()
	end,
})

require('render-markdown').setup({
	file_types = { 'markdown' },
	render_modes = true
})

vim.api.nvim_set_hl(0, 'RenderMarkdownCode', { bg = '#1c1c1c' })
