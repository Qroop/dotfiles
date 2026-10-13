local conform = require('conform')
local mini_extra = require('mini.extra')

vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { desc = 'Code actions' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Goto implementation' })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Goto type definition' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Goto definition' })
vim.keymap.set('n', 'gn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
vim.keymap.set({ 'n', 'v' }, 'gf', function()
	conform.format({ lsp_format = 'fallback' })
end, { desc = 'Format file' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open quick-fix' })
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Line diagnostics' })

vim.keymap.set('n', 'go', function()
	mini_extra.pickers.lsp({ scope = 'document_symbol' })
end, { desc = 'Document symbols' })

vim.keymap.set('n', 'gO', function()
	mini_extra.pickers.lsp({ scope = 'workspace_symbol' })
end, { desc = 'Workspace symbols' })

pcall(vim.keymap.del, 'n', 'gra')
pcall(vim.keymap.del, 'n', 'gri')
pcall(vim.keymap.del, 'n', 'grn')
pcall(vim.keymap.del, 'n', 'grr')
pcall(vim.keymap.del, 'n', 'grt')
pcall(vim.keymap.del, 'n', 'grx')

vim.keymap.set('n', 'gr', function()
	mini_extra.pickers.lsp({ scope = 'references' })
end, { desc = 'Goto references' })
