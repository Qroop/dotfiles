local mini_pick = require('mini.pick')

local M = {}

function M.workspace_symbols(name, kinds)
	vim.lsp.buf.workspace_symbol('', {
		on_list = function(data)
			local items = vim.tbl_filter(function(item)
				return kinds[item.kind] == true
			end, data.items)

			if #items == 0 then
				vim.notify('No ' .. name:lower() .. ' found in the workspace.', vim.log.levels.INFO)
				return
			end

			for _, item in ipairs(items) do
				item.path = item.filename
				item.text = item.text or ''
			end

			mini_pick.start({
				source = {
					name = name,
					items = items,
					show = mini_pick.default_show,
					choose = mini_pick.default_choose,
				},
			})
		end,
	})
end

function M.man_pages()
	local items = vim.fn.systemlist('man -k . 2>/dev/null')
	mini_pick.start({
		source = {
			name = 'Man pages',
			items = items,
			choose = function(item)
				local page, section = item:match('^([^%s(,]+)[^(]*%(([^)]*)%)')
				if page then
					vim.schedule(function()
						vim.cmd.Man(section, page)
					end)
				end
			end,
		},
	})
end

function M.git_changed_files()
	local result = vim.system({ 'git', 'status', '--porcelain=v1', '-z' }, { text = true }):wait()
	if result.code ~= 0 then
		vim.notify('Not in a Git repository.', vim.log.levels.INFO)
		return
	end

	local entries = vim.split(result.stdout, '\0', { plain = true, trimempty = true })
	local items = {}
	local index = 1

	while index <= #entries do
		local entry = entries[index]
		local status = entry:sub(1, 2)
		local path = entry:sub(4)

		table.insert(items, {
			path = path,
			text = status .. ' ' .. path,
		})

		if status:find('[RC]') then
			index = index + 1
		end
		index = index + 1
	end

	if #items == 0 then
		vim.notify('No changed files in this Git repository.', vim.log.levels.INFO)
		return
	end

	mini_pick.start({
		source = {
			name = 'Git changed files',
			items = items,
			show = mini_pick.default_show,
			choose = mini_pick.default_choose,
		},
	})
end

return M
