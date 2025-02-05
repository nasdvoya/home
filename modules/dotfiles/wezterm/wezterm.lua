local wezterm = require("wezterm")
local mux = wezterm.mux
local config = {}
local act = wezterm.action

-- Default program (Bash as login shell)
config.default_prog = { "bash", "--login" }

-- Cursor and window behavior
config.default_cursor_style = "BlinkingBar"
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "TITLE | RESIZE"
config.check_for_updates = false

-- Tab bar settings
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.enable_tab_bar = false

-- Font settings
config.font_size = 11.5
config.font = wezterm.font("JetBrains Mono", { weight = "Regular" })
-- Temp fix
config.front_end = "WebGpu"

-- Window padding
config.window_padding = {
	left = 3,
	right = 3,
	top = 0,
	bottom = 0,
}

-- Unix domains
config.unix_domains = {
	{
		name = "unix",
	},
}

-- keys
config.leader = { key = "q", mods = "ALT" }
config.keys = {
	-- Misc
	{ key = "v", mods = "LEADER", action = act.ActivateCopyMode },
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.6,
}

config.tab_max_width = 32
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#161616",
			fg_color = "#b6b8bb",
		},
	},
}

config.hide_mouse_cursor_when_typing = false
config.colors = {
	foreground = "#ECE1D7",
	background = "#292522",
	cursor_bg = "#ECE1D7",
	cursor_border = "#ECE1D7",
	cursor_fg = "#292522",
	selection_bg = "#403A36",
	selection_fg = "#ECE1D7",
	ansi = {
		"#34302C",
		"#BD8183",
		"#78997A",
		"#E49B5D",
		"#7F91B2",
		"#B380B0",
		"#7B9695",
		"#C1A78E",
	},
	brights = {
		"#867462",
		"#D47766",
		"#85B695",
		"#EBC06D",
		"#A3A9CE",
		"#CF9BC2",
		"#89B3B6",
		"#ECE1D7",
	},
}

wezterm.on("gui-startup", function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

return config
