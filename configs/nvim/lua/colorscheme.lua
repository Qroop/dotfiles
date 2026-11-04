vim.pack.add({"https://github.com/slugbyte/lackluster.nvim"})

vim.o.background = "dark" -- or "light" for light mode

require("lackluster").setup {
	tweak_background = {
		normal = 'none',
	},
}

vim.cmd.colorscheme("lackluster-mint")
vim.api.nvim_set_hl(0, "Comment", { fg = "#6f9f60" })
vim.api.nvim_set_hl(0, "@comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "@lsp.type.comment", { link = "Comment" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#141414" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#141414", fg = "#928374" })
vim.api.nvim_set_hl(0, "FloatTitle", { bg = "#141414" })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#202020" })
