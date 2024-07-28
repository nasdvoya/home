local wezterm = require("wezterm")
local mux = wezterm.mux

local config = {}

-- URL highlighting rules
config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex = "\\((\\w+://\\S+)\\)",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex = "\\[(\\w+://\\S+)\\]",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex = "\\{(\\w+://\\S+)\\}",
    format = "$1",
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex = "<(\\w+://\\S+)>",
    format = "$1",
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    regex = "[^(]\\b(\\w+://\\S+[)/a-zA-Z0-9-]+)",
    format = "$1",
    highlight = 1,
  },
  -- Implicit mailto link
  {
    regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
    format = "mailto:$0",
  },
}

-- Event handling for startup and font adjustment
wezterm.on("gui-startup", function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

-- Readjust font size on window resize to get rid of the padding at the bottom
function readjust_font_size(window, pane)
  local window_dims = window:get_dimensions()
  local pane_dims = pane:get_dimensions()

  local config_overrides = {}
  local initial_font_size = 13 -- Set to your desired font size
  config_overrides.font_size = initial_font_size

  local max_iterations = 5
  local iteration_count = 0
  local tolerance = 3

  -- Calculate the initial difference between window and pane heights
  local current_diff = window_dims.pixel_height - pane_dims.pixel_height
  local min_diff = math.abs(current_diff)
  local best_font_size = initial_font_size

  -- Loop to adjust font size until the difference is within tolerance or max iterations reached
  while current_diff > tolerance and iteration_count < max_iterations do
    wezterm.log_info(
      string.format(
        "Win Height: %d, Pane Height: %d, Height Diff: %d, Curr Font Size: %.2f, Cells: %d, Cell Height: %.2f",
        window_dims.pixel_height,
        pane_dims.pixel_height,
        window_dims.pixel_height - pane_dims.pixel_height,
        config_overrides.font_size,
        pane_dims.viewport_rows,
        pane_dims.pixel_height / pane_dims.viewport_rows
      )
    )

    -- Increment the font size slightly
    config_overrides.font_size = config_overrides.font_size + 0.5
    window:set_config_overrides(config_overrides)

    -- Update dimensions after changing font size
    window_dims = window:get_dimensions()
    pane_dims = pane:get_dimensions()
    current_diff = window_dims.pixel_height - pane_dims.pixel_height

    -- Check if the current difference is the smallest seen so far
    local abs_diff = math.abs(current_diff)
    if abs_diff < min_diff then
      min_diff = abs_diff
      best_font_size = config_overrides.font_size
    end

    iteration_count = iteration_count + 1
  end

  -- If no acceptable difference was found, set the font size to the best one encountered
  if current_diff > tolerance then
    config_overrides.font_size = best_font_size
    window:set_config_overrides(config_overrides)
  end
end

local selected_theme = stdout:gsub("%s+", "") -- Remove all whitespace characters including newline
config.color_scheme = "One Dark (Gogh)";

return config
