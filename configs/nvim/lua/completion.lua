-- Completion: blink.cmp menu fed by LSP, snippets and Copilot.

-- copilot.lua acts purely as the Copilot backend here: its inline suggestions
-- and panel are disabled so that proposals only show up in the blink menu.
require('copilot').setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

-- Returns the keys that jump past the closing pair under/next to the cursor,
-- or nil when there is nothing to tab out of (blink then falls through to a
-- plain <Tab>). See lua/plugins.lua for the neotab setup.
local function tabout()
	local pos = vim.api.nvim_win_get_cursor(0)
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local ok, md = pcall(require('neotab.tab').out, lines, pos)
	if not ok or not md or md.pos <= pos[2] + 1 then return end

	return vim.api.nvim_replace_termcodes(
		'<Cmd>lua require("neotab.utils").set_cursor(' .. md.pos .. ')<CR>',
		true, false, true
	)
end

-- Sources whose items should never auto-insert on selection: snippets and
-- Copilot suggestions are expansions/multi-line proposals we want to review
-- before committing, so they only apply on an explicit <CR> accept. Plain
-- text items (lsp, path, buffer) still auto-insert as you arrow through them.
local no_preview_sources = { snippets = true, copilot = true }

-- Peeks at the item a <C-j>/<C-k> move would land on and only auto-inserts
-- it if it isn't from a no_preview_sources source. Out-of-range targets
-- (deselecting at a list boundary) have no item, so auto_insert is moot.
local function move_selection(direction)
	return function(cmp)
		local idx = cmp.get_selected_item_idx()
		local target = (idx or 0) + direction
		local item = cmp.get_items()[target]
		local auto_insert = not (item and no_preview_sources[item.source_id])

		if direction > 0 then
			return cmp.select_next({ auto_insert = auto_insert })
		else
			return cmp.select_prev({ auto_insert = auto_insert })
		end
	end
end

require('blink.cmp').setup({
	keymap = {
		preset = 'none',

		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide', 'fallback' },

		['<C-j>'] = { 'show', move_selection(1), 'fallback' },
		['<C-k>'] = { 'show', move_selection(-1), 'fallback' },

		['<CR>'] = { 'accept', 'fallback' },

		-- Snippet placeholder jump first, then tab out of a closing pair,
		-- then a plain tab. blink runs these in an <expr> mapping, where
		-- moving the cursor is blocked by textlock, so only the (pure)
		-- lookup happens here and the actual jump is returned as keys.
		['<Tab>'] = { 'snippet_forward', tabout, 'fallback' },
		['<S-Tab>'] = { 'snippet_backward', 'fallback' },

		['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
		['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
	},

	appearance = { nerd_font_variant = 'mono' },

	completion = {
		menu = { auto_show = true },
		-- Nothing is selected until <C-j>/<C-k> is pressed, so a bare <CR>
		-- still inserts a newline.
		list = { selection = { preselect = false, auto_insert = false } },
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
	},

	-- Neovim's built-in vim.snippet engine.
	snippets = { preset = 'default' },

	sources = {
		default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
		providers = {
			copilot = {
				name = 'copilot',
				module = 'blink-copilot',
				score_offset = 100,
				async = true,
			},
		},
	},

	signature = { enabled = true },

	-- Prefer the prebuilt Rust matcher, but degrade to Lua with a warning
	-- rather than erroring if the binary could not be downloaded.
	fuzzy = { implementation = 'prefer_rust_with_warning' },
})
