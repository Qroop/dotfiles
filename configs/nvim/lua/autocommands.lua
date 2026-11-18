local group = vim.api.nvim_create_augroup("config-autocmds", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("TermOpen", {
	group = group,
	desc = "Show line numbers in terminal buffers",
	callback = function()
		vim.opt_local.number = true
		vim.opt_local.relativenumber = true
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = group,
	callback = function()
		if vim.bo.buftype ~= "nofile" then
			vim.cmd("silent! checktime")
		end
	end,
})

-- Delete [No Name] buffers
vim.api.nvim_create_autocmd("BufHidden", {
	callback = function(a)
		if vim.api.nvim_buf_get_name(a.buf) == "" and not vim.bo[a.buf].modified and vim.bo[a.buf].buftype == "" then
			vim.schedule(function()
				pcall(vim.api.nvim_buf_delete, a.buf, {})
			end)
		end
	end,
})

-- Automatically enter insert mode on switch to terminal
vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, {
	pattern = "term://*",
	callback = function()
		vim.cmd("startinsert")
	end,
})
