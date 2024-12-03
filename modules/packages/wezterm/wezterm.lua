local wezterm = require('wezterm')
local session_manager = require('wezterm-session-manager/session-manager')
local mux = wezterm.mux
local config = {}
local act = wezterm.action

wezterm.on('update-right-status', function(window, pane)
  window:set_right_status(window:active_workspace())
end)
-- Default program (Bash as login shell)
config.default_prog = { 'bash' }

wezterm.on('save_session', function(window) session_manager.save_state(window) end)
wezterm.on('load_session', function(window) session_manager.load_state(window) end)
wezterm.on('restore_session', function(window) session_manager.restore_state(window) end)

-- Cursor and window behavior
config.default_cursor_style = 'BlinkingBar'
config.automatically_reload_config = true
config.window_close_confirmation = 'NeverPrompt'
config.adjust_window_size_when_changing_font_size = false
-- config.window_decorations = 'RESIZE'
config.check_for_updates = false

-- Tab bar settings
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.enable_tab_bar = false

-- Font settings
config.font_size = 11.5
config.font = wezterm.font('JetBrains Mono', { weight = 'Regular' })
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
    name = 'unix',
  },
}

-- keys
config.leader = { key = 'q', mods = 'ALT' }
config.keys = {
  -- Panes
  { key = '-',          mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = '.',          mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'z',          mods = 'LEADER', action = act.TogglePaneZoomState },
  { key = 'm',          mods = 'LEADER', action = act.RotatePanes 'Clockwise' },
  { key = 'x',          mods = 'LEADER', action = act.CloseCurrentPane { confirm = true }, },
  -- Panes -- Resizing
  { key = 'LeftArrow',  mods = 'ALT',    action = act.AdjustPaneSize { 'Left', 5 } },
  { key = 'RightArrow', mods = 'ALT',    action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'ALT',    action = act.AdjustPaneSize { 'Up', 5 } },
  { key = 'DownArrow',  mods = 'ALT',    action = act.AdjustPaneSize { 'Down', 5 } },
  -- Panes -- Moving
  { key = 'h',          mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
  { key = 'l',          mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },
  { key = 'k',          mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
  { key = 'j',          mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
  -- Tabs
  { key = 't',          mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'w',          mods = 'LEADER', action = act.CloseCurrentTab { confirm = true } },
  { key = 'p',          mods = 'LEADER', action = act.ActivateTabRelative(-1) },
  { key = 'n',          mods = 'LEADER', action = act.ActivateTabRelative(1) },
  { key = 'e',          mods = 'LEADER', action = act.ShowTabNavigator },
  -- Windows
  { key = 'Enter',      mods = 'LEADER', action = act.ToggleFullScreen },
  -- Muxer
  { key = 'a',          mods = 'LEADER', action = act.AttachDomain 'unix' },
  { key = 'd',          mods = 'LEADER', action = act.DetachDomain { DomainName = 'unix' } },
  { key = 's',          mods = 'LEADER', action = act.ShowLauncherArgs { flags = 'WORKSPACES' } },
  { key = 's',          mods = 'ALT',    action = act({ EmitEvent = 'save_session' }), },
  { key = 'l',          mods = 'ALT',    action = act({ EmitEvent = 'load_session' }), },
  { key = 'r',          mods = 'ALT',    action = act({ EmitEvent = 'restore_session' }), },
  {
    key = 'º',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(
        function(window, pane, line)
          if line then
            mux.rename_workspace(
              window:mux_window():get_workspace(),
              line
            )
          end
        end
      ),
    },
  },
  -- Misc
  { key = 'v', mods = 'LEADER', action = act.ActivateCopyMode },
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.6,
}

config.tab_max_width = 32
config.colors = {
  tab_bar = {
    active_tab = {
      -- I use a solarized dark theme; this gives a teal background to the active tab
      bg_color = '#161616',
      fg_color = '#b6b8bb'
    }
  }
}

-- Event handling for startup and font adjustment
wezterm.on('gui-startup', function()
  local _, _, window = mux.spawn_window({})
  window:gui_window():maximize()
end)

config.hide_mouse_cursor_when_typing = false
config.colors = {
  foreground    = '#ECE1D7',
  background    = '#292522',
  cursor_bg     = '#ECE1D7',
  cursor_border = '#ECE1D7',
  cursor_fg     = '#292522',
  selection_bg  = '#403A36',
  selection_fg  = '#ECE1D7',
  ansi          = {
    '#34302C',
    '#BD8183',
    '#78997A',
    '#E49B5D',
    '#7F91B2',
    '#B380B0',
    '#7B9695',
    '#C1A78E'
  },
  brights       = {
    '#867462',
    '#D47766',
    '#85B695',
    '#EBC06D',
    '#A3A9CE',
    '#CF9BC2',
    '#89B3B6',
    '#ECE1D7'
  }
}
return config
