local wezterm = require("wezterm")
local config = {
	font = wezterm.font("GeistMono Nerd Font Mono"),
	color_scheme = "Gruvbox Dark (Gogh)",
	window_background_opacity = 0.8,
	-- window_decorations = "RESIZE",
	window_padding = { left = "1cell", right = "1cell", top = "1cell", bottom = "0.5cell" },
	hide_tab_bar_if_only_one_tab = true,
}

return config
