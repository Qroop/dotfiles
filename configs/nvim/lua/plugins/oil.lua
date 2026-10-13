require('oil').setup({
	win_options = {
		signcolumn = "yes:2",
	},
	columns = {
		"permissions",
		"size",
		"mtime",
	},
	keymaps = {
		["<leader>h"] = { "actions.show_help", mode = "n" },
		["<C-p>"] = "actions.preview",
		["<Esc>"] = { "actions.close", mode = "n" },
		["<C-r>"] = "actions.refresh",
		["<BS>"] = { "actions.parent", mode = "n" },
		["<C-h>"] = { "actions.toggle_hidden", mode = "n" },
	},
})

require('oil-git-status').setup()
