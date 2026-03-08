return {
{ 
	'ellisonleao/gruvbox.nvim',
    priority = 1000,  
	config = function()
      require('gruvbox').setup {
        terminal_colors = true,
        transparent_mode = true,
		inverse = true,
      }

	vim.o.background = 'dark' -- or "light" for light mode
      vim.cmd [[colorscheme gruvbox]]
	  vim.cmd.colorscheme("gruvbox")

	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
	vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
	vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })
    end,
  },
}

