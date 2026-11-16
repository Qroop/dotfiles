vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-mini/mini.extra",
	"https://github.com/nvim-mini/mini.pairs",
	"https://github.com/nvim-mini/mini.pick",
	"https://github.com/nvim-mini/mini.notify",
	"https://github.com/nvim-mini/mini.diff",
	"https://github.com/refractalize/oil-git-status.nvim",
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
	"https://github.com/folke/flash.nvim",
	"https://github.com/folke/which-key.nvim",
})

require('plugins.oil')
require('plugins.mini')
require('plugins.ui')
require('plugins.flash')
require('plugins.which-key')
