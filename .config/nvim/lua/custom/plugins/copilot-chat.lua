return {
  'CopilotC-Nvim/CopilotChat.nvim',
  branch = 'main',
  cmd = 'CopilotChat',
  opts = function()
    return {
      auto_insert_mode = true,
      question_header = '  Jesper',
      answer_header = '  Copilot ',
      window = {
        width = 0.4,
      },
    }
  end,
  keys = {
    { '<c-s>', '<CR>', ft = 'copilot-chat', desc = 'Submit Prompt', remap = true },
    { '<leader>a', '', desc = '+ai', mode = { 'n', 'v' } },
    {
      '<leader>aa',
      function()
        return require('CopilotChat').toggle()
      end,
      desc = 'Toggle (CopilotChat)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ax',
      function()
        return require('CopilotChat').reset()
      end,
      desc = 'Clear (CopilotChat)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aq',
      function()
        vim.ui.input({
          prompt = 'Quick Chat: ',
        }, function(input)
          if input ~= '' then
            require('CopilotChat').ask(input)
          end
        end)
      end,
      desc = 'Quick Chat (CopilotChat)',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ap',
      function()
        require('CopilotChat').select_prompt()
      end,
      desc = 'Prompt Actions (CopilotChat)',
      mode = { 'n', 'v' },
    },
    {
      '<C-j>',
      function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Down>', true, false, true), 'n')
      end,
      desc = 'CopilotChat: Next item',
      mode = { 'i', 'n' },
      ft = 'copilot-chat',
    },
    {
      '<C-k>',
      function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Up>', true, false, true), 'n')
      end,
      desc = 'CopilotChat: Previous item',
      mode = { 'i', 'n' },
      ft = 'copilot-chat',
    },
  },
  config = function(_, opts)
    local chat = require 'CopilotChat'

    vim.api.nvim_create_autocmd('BufEnter', {
      pattern = 'copilot-chat',
      callback = function()
        vim.opt_local.relativenumber = false
        vim.opt_local.number = false
      end,
    })

    chat.setup(opts)
  end,
}
