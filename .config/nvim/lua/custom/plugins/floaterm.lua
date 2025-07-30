return {
  'voldikss/vim-floaterm',
  event = 'VeryLazy',
  config = function()
    vim.g.floaterm_borderchars = '─│─│╭╮╯╰'
    vim.g.floaterm_wintype = 'float'
    vim.g.floaterm_title = 'Terminal'
    vim.g.floaterm_autoclose = 1
    vim.g.floaterm_titleposition = 'center'

    vim.cmd [[hi FloatermNC guibg = 'black']]

    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        vim.cmd 'FloatermKill!'
      end,
    })
  end,
}
