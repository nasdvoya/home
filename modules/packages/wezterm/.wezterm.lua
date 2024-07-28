-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'hybrid'

-- Set the font to JetBrains Mono Nerd Font
config.font = wezterm.font('JetBrainsMono Nerd Font')  -- Use the correct name for the installed font
config.font_size = 12.0  -- Set your preferred font size

-- and finally, return the configuration to wezterm
return config
