vim.pack.add({
	"https://github.com/slugbyte/lackluster.nvim",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.snippets",
	"https://github.com/nvim-mini/mini.completion",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.clue",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.notify",
	"https://github.com/nvim-mini/mini.keymap",
	"https://github.com/rafamadriz/friendly-snippets",
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

LSP_list = { "lua_ls", "basedpyright" }
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = LSP_list,
	automatic_installation = true
})

vim.lsp.enable(LSP_list)

-- MINI
require('mini.extra').setup()
require('mini.pairs').setup()
local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
	mappings = {
		expand = '<C-l>',
		jump_next = '',
		jump_prev = '',
	},
	snippets = {
		gen_loader.from_lang(),
	}
})
require('mini.snippets').start_lsp_server()
require('mini.completion').setup()
local map_multistep = require('mini.keymap').map_multistep
map_multistep('i', '<Tab>', {
	'minisnippets_next',
})
map_multistep('i', '<S-Tab>', {
	'minisnippets_prev',
})

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

