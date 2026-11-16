local M = {}

local function label(tab)
	local custom = vim.t[tab].tabname
	if custom and custom ~= "" then
		return custom
	end

	local win = vim.api.nvim_tabpage_get_win(tab)
	local buf = vim.api.nvim_win_get_buf(win)
	local name = vim.api.nvim_buf_get_name(buf)

	if vim.bo[buf].buftype == "terminal" then
		return "term"
	elseif name:match("^oil://") then
		return vim.fn.fnamemodify(name:gsub("^oil://", ""):gsub("/$", ""), ":t") .. "/"
	elseif name == "" then
		return "[No Name]"
	end
	return vim.fn.fnamemodify(name, ":t")
end

local function modified(tab)
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
		if vim.bo[vim.api.nvim_win_get_buf(win)].modified then
			return true
		end
	end
	return false
end

function M.render()
	local current = vim.api.nvim_get_current_tabpage()
	local parts = {}

	for i, tab in ipairs(vim.api.nvim_list_tabpages()) do
		local hl = tab == current and "%#TabLineSel#" or "%#TabLine#"
		local mod = modified(tab) and " +" or ""
		table.insert(parts, string.format("%s%%%dT %d: %s%s ", hl, i, i, label(tab), mod))
	end

	return table.concat(parts) .. "%#TabLineFill#%T"
end

vim.o.tabline = "%!v:lua.require'tabline'.render()"

return M
