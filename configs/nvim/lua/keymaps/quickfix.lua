local function step(cmd, wrap)
	return function()
		if not pcall(vim.cmd, cmd) then
			pcall(vim.cmd, wrap)
		end
	end
end

vim.keymap.set('n', '<leader>qq', function()
	if vim.fn.getqflist({ winid = 0 }).winid ~= 0 then
		vim.cmd.cclose()
	else
		vim.cmd('botright copen')
	end
end, { desc = 'Toggle quickfix' })

vim.keymap.set('n', '<leader>qn', step('cnext', 'cfirst'), { desc = 'Next entry' })
vim.keymap.set('n', '<leader>qp', step('cprevious', 'clast'), { desc = 'Previous entry' })
vim.keymap.set('n', '<leader>qf', '<Cmd>cfirst<CR>', { desc = 'First entry' })
vim.keymap.set('n', '<leader>ql', '<Cmd>clast<CR>', { desc = 'Last entry' })
vim.keymap.set('n', '<leader>qo', '<Cmd>silent! colder<CR>', { desc = 'Older list' })
vim.keymap.set('n', '<leader>qO', '<Cmd>silent! cnewer<CR>', { desc = 'Newer list' })
