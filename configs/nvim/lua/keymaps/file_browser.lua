local oil = require('oil')

vim.keymap.set('n', '<leader>e', function()
	if vim.bo.filetype == 'oil' then
		oil.close()
	else
		oil.open()
	end
end, { desc = 'Toggle oil' })
