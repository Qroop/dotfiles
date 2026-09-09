-- Completion: blink.cmp menu fed by LSP, snippets and Copilot.

-- copilot.lua acts purely as the Copilot backend here: its inline suggestions
-- and panel are disabled so that proposals only show up in the blink menu.
require('copilot').setup({
	suggestion = { enabled = false },
	panel = { enabled = false },
})

require('blink.cmp').setup({
	keymap = {
		preset = 'none',

		['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
		['<C-e>'] = { 'hide', 'fallback' },

		['<C-j>'] = { 'show', 'select_next', 'fallback' },
		['<C-k>'] = { 'show', 'select_prev', 'fallback' },

		['<CR>'] = { 'accept', 'fallback' },

		['<Tab>'] = { 'snippet_forward', 'fallback' },
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
