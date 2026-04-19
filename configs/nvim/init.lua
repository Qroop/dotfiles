---@diagnostic disable: undefined-global, unused-local
vim.g.mapleader = ' '

-- OPTIONS
vim.o.winborder = 'rounded'
vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.showmode = false
vim.o.wrap = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 1000
vim.o.splitright = true
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
	"https://github.com/ellisonleao/gruvbox.nvim",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/nvim-mini/mini.snippets",
	"https://github.com/nvim-mini/mini.completion",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.clue",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.notify",
})

require('gruvbox').setup {
	terminal_colors = true,
	transparent_mode = true,
	inverse = true,
}

vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })

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
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pylsp" },
	automatic_installation = true
})

vim.lsp.enable({
	"lua_ls",
	"pylsp"
})

-- MINI
require('mini.extra').setup()
require('mini.snippets').setup()
require('mini.completion').setup()
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
		delay = 250
	}
})

require('mini.pick').setup({
	mappings = {
		move_down = '<C-j>',
		move_up = '<C-k>',
	}
})

require('mini.notify').setup({
	lsp_progress = {
		enable = false,
	}
})

-- KEYMAPS
vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Goto type defintion' })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', 'gf', vim.lsp.buf.format, { desc = 'Format file' })

vim.keymap.set('n', '<leader>ff', ':Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader><leader>', ':Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fb', ':Pick buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>', { desc = 'Find with grep' })
vim.keymap.set('n', '<leader>fc', ':Pick resume<CR>', { desc = 'Continue last picker' })
vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Find help' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('i', '<C-j>', '<C-n>', { noremap = true })
vim.keymap.set('i', '<C-k>', '<C-p>', { noremap = true })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

vim.keymap.set('c', '<C-j>', '<C-n>', { noremap = true })
vim.keymap.set('c', '<C-k>', '<C-p>', { noremap = true })

vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, { desc = 'Next error' })
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, { desc = 'Prev error' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<CR>', { desc = '[|] Vertical split' })
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', { desc = '[-] Horizontal split' })

vim.keymap.set('n', '<leader>w', '<Cmd>set wrap!<CR>', { desc = 'Toggle wrap' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', 'gO', function()
	MiniExtra.pickers.lsp({ scope = 'document_symbol' })
end, { desc = 'Document symbols (mini.pick)' })

pcall(vim.keymap.del, "n", "gra")
pcall(vim.keymap.del, "n", "gri")
pcall(vim.keymap.del, "n", "grn")
pcall(vim.keymap.del, "n", "grr")
pcall(vim.keymap.del, "n", "grt")
pcall(vim.keymap.del, "n", "grx")

vim.keymap.set('n', 'gr', function()
	MiniExtra.pickers.lsp({ scope = 'references' })
end, { noremap = true, desc = 'Goto references' })
