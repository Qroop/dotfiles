local M = {}

local last = "make -k"

function M.compile()
	vim.ui.input({ prompt = "Compilation command: ", default = last, completion = "shellcmd" }, function(cmd)
		if not cmd or cmd == "" then
			return
		end
		last = cmd
		vim.o.makeprg = cmd
		local win = vim.api.nvim_get_current_win()
		vim.cmd("make")
		vim.cmd("botright cwindow")
		vim.api.nvim_set_current_win(win)
	end)
end

return M
