vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Goto type defintion' })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set({ 'n', 'v' }, 'gf', function()
	require('conform').format({ lsp_format = 'fallback' })
end, { desc = 'Format file' })

local function pick_workspace_symbols(name, kinds)
	vim.lsp.buf.workspace_symbol('', {
		on_list = function(data)
			local items = vim.tbl_filter(function(item)
				return kinds[item.kind] == true
			end, data.items)

			if #items == 0 then
				vim.notify('No ' .. name:lower() .. ' found in the workspace.', vim.log.levels.INFO)
				return
			end

			for _, item in ipairs(items) do
				item.path = item.filename
				item.text = item.text or ''
			end

			MiniPick.start({
				source = {
					name = name,
					items = items,
					show = MiniPick.default_show,
					choose = MiniPick.default_choose,
				},
			})
		end,
	})
end

vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Find Buffers' })
vim.keymap.set('n', '<leader>fc', function()
	pick_workspace_symbols('Classes and Types', {
		Class = true,
		Enum = true,
		Interface = true,
		Struct = true,
	})
end, { desc = 'Find Classes and Types' })
vim.keymap.set('n', '<leader>fd', MiniExtra.pickers.diagnostic, { desc = 'Find Diagnostics' })
vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Find by Grep' })
vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fk', MiniExtra.pickers.keymaps, { desc = 'Find Keymaps' })
vim.keymap.set('n', '<leader>fl', MiniExtra.pickers.buf_lines, { desc = 'Find Buffer Lines' })
vim.keymap.set('n', '<leader>fm', MiniExtra.pickers.marks, { desc = 'Find Marks' })
vim.keymap.set('n', '<leader>fo', MiniExtra.pickers.oldfiles, { desc = 'Find Recent Files' })
vim.keymap.set('n', '<leader>fp', function()
	pick_workspace_symbols('Procedures', {
		Constructor = true,
		Function = true,
		Method = true,
	})
end, { desc = 'Find Procedures' })
vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>', { desc = 'Resume Picker' })
vim.keymap.set('n', '<leader>fs', MiniExtra.pickers.spellsuggest, { desc = 'Find Spelling Suggestions' })
vim.keymap.set('n', '<leader>fv', function()
	pick_workspace_symbols('Variables', {
		Constant = true,
		EnumMember = true,
		Field = true,
		Property = true,
		Variable = true,
	})
end, { desc = 'Find Variables' })

vim.keymap.set('n', '<leader>fB', MiniExtra.pickers.git_branches, { desc = 'Find Git Branches' })
vim.keymap.set('n', '<leader>fC', MiniExtra.pickers.commands, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fG', MiniExtra.pickers.git_commits, { desc = 'Find Git Commits' })
vim.keymap.set('n', '<leader>fH', MiniExtra.pickers.history, { desc = 'Find Command History' })
vim.keymap.set('n', '<leader>fO', MiniExtra.pickers.options, { desc = 'Find Options' })
vim.keymap.set('n', '<leader>fR', MiniExtra.pickers.registers, { desc = 'Find Registers' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open quick-fix' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<CR>', { desc = 'V. split' })
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', { desc = 'H. split' })

vim.keymap.set('n', '<leader>w', '<Cmd>set wrap!<CR>', { desc = 'Toggle Wrap' })

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')

vim.keymap.set('n', 'Q', 'gqq', { desc = 'Auto-wrap lines of line' })
vim.keymap.set('v', 'Q', 'gq', { desc = 'Auto-wrap lines of paragraph' })
vim.keymap.set('n', '<leader>s', '<Cmd>source ~/.config/nvim/init.lua<CR>', { desc = 'Source config' })

-- vim.keymap.set('n', '<C-c>', function()
-- 	vim.cmd('silent make')
--
-- 	for index, item in ipairs(vim.fn.getqflist()) do
-- 		if item.valid == 1 and item.type:upper() == 'E' then
-- 			vim.cmd(('cc %d'):format(index))
-- 			return
-- 		end
-- 	end
--
-- 	vim.cmd('cwindow')
-- end, { desc = 'Compile and jump to first error' })

vim.keymap.set('n', '<C-c>', '<Cmd>wa<CR><Cmd>make<CR>')

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

vim.keymap.set('n', '<leader>e', function()
	if vim.bo.filetype == 'oil' then
		require('oil').close()
	else
		require('oil').open()
	end
end, { desc = 'Toggle file explorer' })

vim.keymap.set('n', '<leader>m', '<Cmd>RenderMarkdown toggle<CR>', { desc = 'Toggle Markdown preview' })

vim.keymap.set('n', 'gx', function()
	local cfile = vim.fn.expand('<cfile>')
	if cfile:match('^%a[%w+.-]*://') then
		vim.ui.open(cfile)
	else
		vim.cmd('edit ' .. vim.fn.fnameescape(cfile))
	end
end, { desc = 'Open file under cursor in Neovim (URLs in browser)' })
