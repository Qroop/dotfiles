vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.clue",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.notify",
	-- Completion: blink.cmp must sit on a release tag so that it can download
	-- its prebuilt fuzzy-matcher binary instead of building it with cargo.
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = vim.version.range('1.*'),
	},
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/zbirenbaum/copilot.lua",
	"https://github.com/fang2hou/blink-copilot",
})

require('oil').setup({
	columns = {
		"permissions",
		"size",
		"mtime",
	},
	keymaps = {
		["<leader>h"] = { "actions.show_help", mode = "n" },
		["<C-p>"] = "actions.preview",
		["<Esc>"] = { "actions.close", mode = "n" },
		["<C-r>"] = "actions.refresh",
		["<BS>"] = { "actions.parent", mode = "n" },
		["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
	},
})

-- MINI
require('mini.extra').setup()
require('mini.pairs').setup()

require('mini.clue').setup({
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
		delay = 500
	}
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
			local height = math.floor(0.35 * vim.o.lines) -- ~30% of terminal height
			return {
				anchor = "NW",
				height = height,
				width = vim.o.columns, -- full terminal width
				row = vim.o.lines - height - 2, -- pin to bottom (optional)
				col = 0,
			}
		end,
	},
})

require('mini.notify').setup({ lsp_progress = { enable = false, } })

