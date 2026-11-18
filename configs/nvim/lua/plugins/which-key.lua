require('which-key').setup({
	preset = 'modern',
	delay = 250,
	spec = {
		{ '<leader>f', group = 'Find' },
		{ '<leader>q', group = 'Quickfix' },
		{ '<leader>s', group = 'Source' },
		{ '<leader>t', group = 'Tabpage' },
	},
	win = {
		row = -1,
		col = 0,
		width = vim.o.columns - 2,
		title_pos = 'left',
	},
})
