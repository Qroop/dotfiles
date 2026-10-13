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

return M
