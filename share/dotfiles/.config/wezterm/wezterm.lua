local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Selenized Dark (Gogh)"
	else
		return "Selenized Light (Gogh)"
	end
end

local color_scheme = scheme_for_appearance(get_appearance())
local color_scheme_def = wezterm.color.get_builtin_schemes()["Selenized Light (Gogh)"]

config.color_scheme = color_scheme
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.font = wezterm.font("FiraCode Nerd Font")
config.font_size = 16.0

config.window_frame = {
	font = wezterm.font({ family = "Fira Sans", weight = "Bold" }),
	font_size = 14.0,
	active_titlebar_bg = "#ece3cc",
	inactive_titlebar_bg = "#d5cdb6",
}

config.window_padding = {
	left = 8,
	right = 8,
	top = 4,
	bottom = 0,
}

config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = color_scheme_def.foreground,
			fg_color = color_scheme_def.background,
		},
	},
}

config.show_new_tab_button_in_tab_bar = false

return config
