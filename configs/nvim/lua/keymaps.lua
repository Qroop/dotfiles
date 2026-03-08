vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })

vim.keymap.set('n', '<C-n>', vim.diagnostic.goto_next, { desc = 'Next error' })
vim.keymap.set('n', '<C-p>', vim.diagnostic.goto_prev, { desc = 'Prev error' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>sr', '<Cmd>GrugFar<CR>', { desc = '[S]earch [R]eplace' })

vim.keymap.set('n', '<leader>tn', '<Cmd>NoNeckPain<CR>', { desc = '[T]oggle [N]oNeckPain' })
vim.keymap.set('n', '<leader>|', '<Cmd>vsplit<CR>', { desc = '[|] Vertical split' })
vim.keymap.set('n', '<leader>-', '<Cmd>split<CR>', { desc = '[-] Horizontal split' })

vim.keymap.set('n', '<leader>L', '<Cmd>Lazy<CR>', { desc = '[L] Open Lazy'})
