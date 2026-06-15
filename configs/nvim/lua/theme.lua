vim.o.background = "dark" -- or "light" for light mode

require("lackluster").setup {
	tweak_background = {
		normal = 'none',
	},
}

vim.cmd.colorscheme("lackluster-mint")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })

vim.cmd.colorscheme("lackluster-mint")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#282828", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#282828" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#141414" })


