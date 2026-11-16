vim.keymap.set("n", "<leader>w", "<Cmd>set wrap!<CR>", { desc = "Toggle wrap" })
vim.keymap.set("n", "<Esc>", "<Cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "Q", "gqq", { desc = "Auto-wrap lines of line" })
vim.keymap.set("v", "Q", "gq", { desc = "Auto-wrap lines of paragraph" })
local function reload(module)
	for name in pairs(package.loaded) do
		if name == module or vim.startswith(name, module .. ".") then
			package.loaded[name] = nil
		end
	end
	require(module)
	vim.notify("Reloaded " .. module)
end

local reloads = {
	{ "k", "keymaps", "Reload keymaps" },
	{ "o", "options", "Reload options" },
	{ "a", "autocommands", "Reload autocommands" },
	{ "l", "lsp", "Reload lsp" },
	{ "c", "colorscheme", "Reload colorscheme" },
	{ "C", "completion", "Reload completion" },
	{ "p", "plugins", "Reload plugins" },
}
for _, r in ipairs(reloads) do
	vim.keymap.set("n", "<leader>s" .. r[1], function()
		reload(r[2])
	end, { desc = r[3] })
end

vim.keymap.set("n", "<leader>ss", function()
	for _, r in ipairs(reloads) do
		reload(r[2])
	end
end, { desc = "Reload all config" })
vim.keymap.set("n", "<C-c>", "<Cmd>make<CR>")
vim.keymap.set("n", "<leader>m", "<Cmd>RenderMarkdown toggle<CR>", { desc = "Toggle Markdown preview" })
vim.keymap.set("n", "<leader>M", "<Cmd>Mason<CR>", { desc = "Open Mason" })

vim.keymap.set("n", "gx", function()
	local cfile = vim.fn.expand("<cfile>")
	if cfile:match("^%a[%w+.-]*://") then
		vim.ui.open(cfile)
	else
		vim.cmd("edit " .. vim.fn.fnameescape(cfile))
	end
end, { desc = "Open file under cursor in Neovim (URLs in browser)" })

local flash = require("flash")
vim.keymap.set({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", flash.remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", flash.treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "<C-s>", flash.toggle, { desc = "Toggle Flash Search" })

vim.keymap.set("n", "<leader>g", "<cmd>Neogit<cr>", { desc = "Open Neogit" })
