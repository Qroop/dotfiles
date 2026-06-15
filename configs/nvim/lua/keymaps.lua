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

vim.keymap.set('n', '<C-m>', ':make<CR>')

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

vim.keymap.set('n', '<leader>e', ':Oil<CR>', { desc = 'Open file explorer' })
