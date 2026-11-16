local modes = { 'n', 't' }

for i = 1, 9 do
	local cmd = '<Cmd>' .. i .. 'tabnext<CR>'
	vim.keymap.set(modes, '<A-' .. i .. '>', cmd, { desc = 'Go to tabpage ' .. i })
	vim.keymap.set(modes, '<C-t>' .. i, cmd, { desc = 'Go to tabpage ' .. i })
end

vim.keymap.set(modes, '<C-t>n', '<Cmd>tabnew<CR>', { desc = 'New tabpage' })
vim.keymap.set(modes, '<C-t>t', '<Cmd>tabnew | terminal<CR>', { desc = 'New terminal tabpage' })
vim.keymap.set(modes, '<C-t>c', '<Cmd>tabclose<CR>', { desc = 'Close tabpage' })
vim.keymap.set(modes, '<C-t>o', '<Cmd>tabonly<CR>', { desc = 'Close other tabpages' })

vim.keymap.set(modes, '<C-t>r', function()
	vim.ui.input({ prompt = 'Tab name: ', default = vim.t.tabname or '' }, function(name)
		if name == nil then
			return
		end
		vim.t.tabname = name ~= '' and name or nil
		vim.cmd.redrawtabline()
	end)
end, { desc = 'Rename tabpage' })

vim.keymap.set(modes, '<C-t>l','<Cmd>tabnext<CR>', { desc = 'Next tabpage' })
vim.keymap.set(modes, '<C-t>h', '<Cmd>tabprevious<CR>', { desc = 'Previous tabpage' })
vim.keymap.set(modes, '<C-t>L', '<Cmd>tabmove +1<CR>', { desc = 'Move tabpage right' })
vim.keymap.set(modes, '<C-t>H', '<Cmd>tabmove -1<CR>', { desc = 'Move tabpage left' })
vim.keymap.set(modes, '<C-t><C-t>', function()
	vim.cmd.normal({ 'g\t', bang = true })
end, { desc = 'Last accessed tabpage' })
