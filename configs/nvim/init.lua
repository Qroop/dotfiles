---@diagnostic disable: undefined-global, unused-local
vim.g.mapleader = ' '
-- Clone 'mini.nvim' manually in a way that it gets managed by 'mini.deps'
local path_package = vim.fn.stdpath('data') .. '/site/'
local mini_path = path_package .. 'pack/deps/start/mini.nvim'
if not vim.loop.fs_stat(mini_path) then
	vim.cmd('echo "Installing [`mini.nvim`](../doc/mini-nvim.qmd#mini.nvim)" | redraw')
	local clone_cmd = {
		'git', 'clone', '--filter=blob:none',
		'https://github.com/nvim-mini/mini.nvim', mini_path
	}
	vim.fn.system(clone_cmd)
	vim.cmd('packadd mini.nvim | helptags ALL')
	vim.cmd('echo "Installed [`mini.nvim`](../doc/mini-nvim.qmd#mini.nvim)" | redraw')
end


-- OPTIONS
vim.o.winborder = 'rounded'

vim.o.number = true
vim.o.relativenumber = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

vim.o.timeoutlen = 1000

-- Configure how new splits should be opened
vim.o.splitright = true

vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
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
-- Use 'mini.deps'. `now()` and `later()` are helpers for a safe two-stage
-- Set up 'mini.deps' (customize to your liking)
require('mini.deps').setup({ path = { package = path_package } })
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

-- GRUVBOX
add({ source = 'ellisonleao/gruvbox.nvim', })
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

add({ source = 'stevearc/oil.nvim' })
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
add({ source = 'mason-org/mason.nvim' })
add({ source = 'mason-org/mason-lspconfig.nvim' })
add({ source = 'neovim/nvim-lspconfig' })

require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = { "lua_ls", "pylsp" },
	automatic_installation = true
})

vim.lsp.enable({
	"lua_ls",
	"pylsp"
})

vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'Goto references' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Goto type defintion' })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set('n', 'gf', vim.lsp.buf.format, { desc = 'Format file' })


-- MINI
require('mini.snippets').setup()   -- https://nvim-mini.org/mini.nvim/doc/mini-snippets.html
require('mini.completion').setup() -- https://nvim-mini.org/mini.nvim/doc/mini-completion.html
require('mini.pairs').setup()      -- https://nvim-mini.org/mini.nvim/doc/mini-pairs.html
require('mini.clue').setup({       -- https://nvim-mini.org/mini.nvim/doc/mini-clue.html
	triggers = {
		{
			mode = 'n',
			keys = '<leader>'
		},
		{
			mode = 'n',
			keys = 'g'
		},
		{
			mode = 'n',
			keys = 'f'
		},
	},
	window = {
		delay = 250
	}
})

-- https://nvim-mini.org/mini.nvim/doc/mini-pick.html
require('mini.pick').setup({
	mappings = {
		move_down = '<C-j>',
		move_up = '<C-k>',
	}
})
vim.keymap.set('n', 'ff', ':Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', 'fb', ':Pick buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', 'fp', ':Pick grep_live<CR>', { desc = 'Find phrase' })
vim.keymap.set('n', '<leader>h', ':Pick help<CR>', { desc = 'Find help' })
require('mini.notify').setup()

-- KEYMAPS
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
