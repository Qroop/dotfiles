require('mini.diff').setup({ view = { style = 'sign' } })
require('mini.extra').setup()
require('mini.pairs').setup()

local miniclue = require('mini.clue')
miniclue.setup({
	triggers = {
		{
			mode = 'n',
			keys = '<leader>'
		},
		{
			mode = 'n',
			keys = 'g'
		},
	},
	window = {
		delay = 500,
	},
	clues = {
		miniclue.gen_clues.square_brackets(),
		miniclue.gen_clues.builtin_completion(),
		miniclue.gen_clues.g(),
		miniclue.gen_clues.marks(),
		miniclue.gen_clues.registers(),
		miniclue.gen_clues.windows(),
		miniclue.gen_clues.z(),
	},
})

require('mini.pick').setup({
	options = {
		content_from_bottom = true,
	},
	mappings = {
		move_down         = '<C-j>',
		move_up           = '<C-k>',
		choose_in_split   = '<C-s>',
		choose_in_tabpage = '<C-t>',
		choose_in_vsplit  = '<C-v>',
		scroll_left       = '<C-q>',
	},
	window = {
		config = function()
			local height = math.floor(0.35 * vim.o.lines)
			return {
				anchor = "NW",
				height = height,
				width = vim.o.columns,
				row = vim.o.lines - height - 2,
				col = 0,
			}
		end,
	},
})

require('mini.notify').setup({ lsp_progress = { enable = false } })
