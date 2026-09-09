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

require('blink.cmp').setup({
	keymap = {
		preset = 'none',

		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide', 'fallback' },

		['<C-j>'] = { 'show', 'select_next', 'fallback' },
		['<C-k>'] = { 'show', 'select_prev', 'fallback' },

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
