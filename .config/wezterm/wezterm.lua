local wezterm = require("wezterm")

local config = {
	font = wezterm.font("GeistMono Nerd Font Mono"),
	font_size = 14,
	color_scheme = "Gruvbox Dark (Gogh)",
	window_background_opacity = 0.75,
	window_decorations = "RESIZE",
	window_padding = { left = "1cell", right = "1cell", top = "1cell", bottom = "0.5cell" },
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,

	-- Add the custom keybinding here
	keys = {
		{
			key = "Space",
			mods = "ALT",
			action = wezterm.action.ActivateCopyMode, -- Correct way to call the action
		},
	},
}

return config
