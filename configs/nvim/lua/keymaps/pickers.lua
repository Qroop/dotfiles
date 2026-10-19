local pickers = require('pickers')
local mini_extra = require('mini.extra')

vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader><leader>', '<Cmd>Pick files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find buffers' })
vim.keymap.set('n', '<leader>fc', function()
	pickers.workspace_symbols('Classes and Types', {
		Class = true,
		Enum = true,
		Interface = true,
		Struct = true,
	})
end, { desc = 'Find classes and types' })
vim.keymap.set('n', '<leader>fd', mini_extra.pickers.diagnostic, { desc = 'Find diagnostics' })
vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Find by grep' })
vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find help' })
vim.keymap.set('n', '<leader>fk', mini_extra.pickers.keymaps, { desc = 'Find keymaps' })
vim.keymap.set('n', '<leader>fl', mini_extra.pickers.buf_lines, { desc = 'Find buffer lines' })
vim.keymap.set('n', '<leader>fm', mini_extra.pickers.marks, { desc = 'Find marks' })
vim.keymap.set('n', '<leader>fo', mini_extra.pickers.oldfiles, { desc = 'Find recent files' })
vim.keymap.set('n', '<leader>fp', function()
	pickers.workspace_symbols('Procedures', {
		Constructor = true,
		Function = true,
		Method = true,
	})
end, { desc = 'Find procedures' })
vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>', { desc = 'Resume picker' })
vim.keymap.set('n', '<leader>fs', mini_extra.pickers.spellsuggest, { desc = 'Find spelling suggestions' })
vim.keymap.set('n', '<leader>fv', function()
	pickers.workspace_symbols('Variables', {
		Constant = true,
		EnumMember = true,
		Field = true,
		Property = true,
		Variable = true,
	})
end, { desc = 'Find variables' })

vim.keymap.set('n', '<leader>fB', mini_extra.pickers.git_branches, { desc = 'Find Git branches' })
vim.keymap.set('n', '<leader>fC', mini_extra.pickers.commands, { desc = 'Find Ex commands' })
vim.keymap.set('n', '<leader>fD', pickers.git_changed_files, { desc = 'Find Git changed files' })
vim.keymap.set('n', '<leader>fG', mini_extra.pickers.git_commits, { desc = 'Find Git commits' })
vim.keymap.set('n', '<leader>fH', mini_extra.pickers.history, { desc = 'Find command history' })
vim.keymap.set('n', '<leader>fM', pickers.man_pages, { desc = 'Find man pages' })
vim.keymap.set('n', '<leader>fO', mini_extra.pickers.options, { desc = 'Find options' })
vim.keymap.set('n', '<leader>fR', mini_extra.pickers.registers, { desc = 'Find registers' })
