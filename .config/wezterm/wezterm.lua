local wezterm = require("wezterm")
local config = {
	font = wezterm.font("GeistMono Nerd Font Mono"),
	color_scheme = "Gruvbox Dark (Gogh)",
	window_background_opacity = 0.8,
	window_decorations = "RESIZE",
	window_padding = { left = "0cell", right = "0cell", top = "0cell", bottom = "0cell" },
	hide_tab_bar_if_only_one_tab = true,
}

return config
