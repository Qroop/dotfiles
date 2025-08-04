-- Make sure autochdir is off once at startup
vim.api.nvim_command 'set noautochdir'

local function project_switch(opts)
  local show_hidden = opts.args == 'hidden'
  local find_cmd = {
    'fdfind',
    '--type',
    'd',
    '--max-depth',
    '4',
    '--absolute-path',
  }

  if show_hidden then
    table.insert(find_cmd, '-H')
  end

  local themes = require 'telescope.themes'
  local actions = require 'telescope.actions'
  local action_state = require 'telescope.actions.state'

  require('telescope.builtin').find_files(themes.get_ivy {
    cwd = vim.fn.expand '~',
    find_command = find_cmd,
    promt_title = '',
    results_title = '',
    sorting_strategy = 'descending',
    previewer = false,
    layout_config = {
      prompt_position = 'bottom',
      height = 0.3,
    },
    attach_mappings = function(prompt_bufnr, map)
      map('i', '<CR>', function()
        local sel = action_state.get_selected_entry()
        if not sel or not sel[1] then
          actions.close(prompt_bufnr)
          return
        end

        actions.close(prompt_bufnr)

        -- Use Ivy for the second picker too
        require('telescope.builtin').find_files(themes.get_ivy {
          cwd = sel[1],
          attach_mappings = function(inner_bufnr, inner_map)
            local inner_actions = require 'telescope.actions'
            local inner_action_state = require 'telescope.actions.state'

            inner_map('i', '<CR>', function()
              local file_sel = inner_action_state.get_selected_entry()
              if file_sel then
                vim.api.nvim_set_current_dir(sel[1])
                vim.fn.writefile({ sel[1] }, '/tmp/nvim-cwd')
              end
              inner_actions.select_default(inner_bufnr)
            end)

            return true
          end,
        })
      end)

      return true
    end,
  })
end

-- Define the base command
vim.api.nvim_create_user_command('ProjectSwitch', function()
  project_switch { args = '' }
end, {})

-- Define the hidden variant
vim.api.nvim_create_user_command('ProjectSwitchHidden', function()
  project_switch { args = 'hidden' }
end, {})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    local argv = vim.fn.argv()
    if #argv == 1 and vim.fn.isdirectory(argv[1]) == 1 then
      require('telescope.builtin').find_files()
    end
  end,
})
