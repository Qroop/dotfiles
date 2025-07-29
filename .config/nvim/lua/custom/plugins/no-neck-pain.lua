return {
  'shortcuts/no-neck-pain.nvim',
  version = '*',

  config = function()
    require('no-neck-pain').setup ({
      width = 100,
    })

  end,
  cmd = 'NoNeckPain',
}
