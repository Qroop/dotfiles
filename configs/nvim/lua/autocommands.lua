vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.makeprg = "go build"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "cs",
	callback = function()
		vim.opt_local.makeprg = "dotnet build"
		vim.opt_local.errorformat = "%f(%l\\,%c): %t%*[^ ] CS%n: %m"
	end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
callback = function()
  if vim.bo.buftype ~= "nofile" then
	vim.cmd("silent! checktime")
  end
end,
})
