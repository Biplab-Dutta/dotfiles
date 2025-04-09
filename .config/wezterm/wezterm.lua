local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

config = {
  automatically_reload_config = true,
  enable_tab_bar = false,
  window_close_confirmation = 'NeverPrompt',
  window_decorations = 'RESIZE',
  default_cursor_style = 'BlinkingBar',
  color_scheme = 'Catppuccin Mocha',
  font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Medium' }),
  font_size = 14,
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- background = {
  --   {
  --     source = {
  --       File = '/Users/' .. os.getenv 'USER' .. '/.config/wezterm/zoro.jpg',
  --     },
  --     hsb = {
  --       hue = 1.0,
  --       saturation = 1.02,
  --       brightness = 0.25,
  --     },
  --     width = '100%',
  --     height = '100%',
  --   },
  --   {
  --     source = {
  --       Color = '#282c35',
  --     },
  --     width = '100%',
  --     height = '100%',
  --     opacity = 0.7,
  --   },
  -- },
  keys = {
    {
      key = '_',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = '|',
      mods = 'CTRL|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
  },
}

return config
