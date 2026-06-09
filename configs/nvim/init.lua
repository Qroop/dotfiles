---@diagnostic disable: undefined-global, unused-local
vim.g.mapleader = ' '

-- OPTIONS
vim.o.winborder = 'rounded'
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.showmode = true
vim.o.wrap = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 1000
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 8
vim.o.confirm = true
vim.opt.expandtab = false -- Use tabs, not spaces
vim.opt.tabstop = 4       -- Display width of a tab character
vim.opt.shiftwidth = 4    -- Indent/outdent by 4 spaces (or 1 tab in this case)
vim.opt.softtabstop = 4   -- Makes <Tab> and <BS> behave like 4-space wide tabs
vim.opt.swapfile = false

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- PLUGINS
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
	"https://github.com/folke/flash.nvim",
})

vim.o.background = "dark" -- or "light" for light mode

local lackluster = require("lackluster")

require("lackluster").setup {
	tweak_background = {
		normal = 'none',
	},
}

vim.cmd.colorscheme("lackluster-mint")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })

vim.cmd.colorscheme("lackluster-mint")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#141414" })

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
vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = 'Open file explorer' })

-- LSP
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
		move_down = '<C-j>',
		move_up = '<C-k>',
		choose_in_split = '-',
		choose_in_vsplit = '|',
		scroll_left = '<C-q>',
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
require('flash').setup({})

-- KEYMAPS
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Goto type defintion' })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', 'gf', vim.lsp.buf.format, { desc = 'Format file' })

vim.keymap.set('n', '<leader>f', ':Pick files<CR>', { desc = 'Find File' })
vim.keymap.set('n', '<leader>b', ':Pick buffers<CR>', { desc = 'Find Buffer' })
vim.keymap.set('n', '<leader>g', ':Pick grep_live<CR>', { desc = 'Grep' })
vim.keymap.set('n', '<leader>c', ':Pick resume<CR>', { desc = 'Continue grep' })
vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Help' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open quick-fix' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<CR>', { desc = '[|] V. split' })
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', { desc = '[-] H. split' })

vim.keymap.set('n', '<leader>w', '<Cmd>set wrap!<CR>', { desc = 'Toggle [W]rap' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-j>', '<C-n>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<C-p>', { noremap = true })

vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, { desc = 'Next error' })
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, { desc = 'Prev error' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', 'Q', 'gqq', { desc = 'Auto-wrap lines of paragraph' })
vim.keymap.set('n', '<leader>s', ':source ~/.config/nvim/init.lua<CR>', { desc = 'Source config' })
vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end)

vim.keymap.set('n', 'go', function()
	MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end, { desc = 'Document Symbols' })

vim.keymap.set('n', 'gO', function()
	MiniExtra.pickers.lsp({ scope = 'workspace_symbol' })
end, { desc = 'Workspace Symbols' })

pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "gri")
pcall(vim.keymap.del, "n", "grn")
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "grt")
pcall(vim.keymap.del, "n", "grx")

vim.keymap.set('n', 'gr', function()
	MiniExtra.pickers.lsp({ scope = 'references' })
end, { noremap = true, desc = 'Goto references' })

vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = { "*.txt" },
	callback = function()
		if vim.bo.filetype == "help" then
			vim.cmd("only")
		end
	end,
})
