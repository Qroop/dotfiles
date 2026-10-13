vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.clue",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.notify",
	"https://github.com/nvim-mini/mini.diff",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
})

require('plugins.oil')
require('plugins.mini')
require('plugins.ui')
