local ctrl_modes = { 'n', 't', 'i' }

local function map(suffix, rhs, desc, ctrl_suffix)
	vim.keymap.set(ctrl_modes, '<C-t>' .. (ctrl_suffix or suffix), rhs, { desc = desc })
	vim.keymap.set('n', '<leader>t' .. suffix, rhs, { desc = desc })
end

for i = 1, 9 do
	local cmd = '<Cmd>' .. i .. 'tabnext<CR>'
	vim.keymap.set(ctrl_modes, '<A-' .. i .. '>', cmd, { desc = 'Go to tabpage ' .. i })
	map(tostring(i), cmd, 'Go to tabpage ' .. i)
end

map('n', '<Cmd>tabnew<CR>', 'New tabpage')
map('N', '<Cmd>-tabnew<CR>', 'New tabpage before')
map('t', '<Cmd>tabnew | terminal<CR>', 'New terminal tabpage')
map('c', '<Cmd>tabclose<CR>', 'Close tabpage')
map('o', '<Cmd>tabonly<CR>', 'Close other tabpages')

map('r', function()
	vim.ui.input({ prompt = 'Tab name: ', default = vim.t.tabname or '' }, function(name)
		if name == nil then
			return
		end
		vim.t.tabname = name ~= '' and name or nil
		vim.cmd.redrawtabline()
	end)
end, 'Rename tabpage')

map('l', '<Cmd>tabnext<CR>', 'Next tabpage')
map('h', '<Cmd>tabprevious<CR>', 'Previous tabpage')
map('L', '<Cmd>tabmove +1<CR>', 'Move tabpage right')
map('H', '<Cmd>tabmove -1<CR>', 'Move tabpage left')
map('<leader>', function()
	vim.cmd.normal({ 'g\t', bang = true })
end, 'Last accessed tabpage', '<C-t>')
