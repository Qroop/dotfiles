-- Make sure autochdir is off once at startup
vim.api.nvim_command 'set noautochdir'

-- Your command that picks and sets cwd
vim.api.nvim_create_user_command('ProjectSwitch', function()
  require('telescope.builtin').find_files {
    prompt_title = 'Find Project Directory',
    cwd = vim.fn.expand '~',
    find_command = { 'fd', '--type', 'd', '--max-depth', '4', '--absolute-path' },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      map('i', '<CR>', function()
        local sel = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        vim.api.nvim_set_current_dir(sel[1])
        vim.fn.writefile({ sel[1] }, '/tmp/nvim-cwd')

        vim.cmd 'Telescope find_files'
      end)

      return true
    end,
  }
end, {})
