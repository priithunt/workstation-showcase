local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.font = wezterm.font_with_fallback({
  { family = "Iosevka Nerd Font Mono", weight = "Regular" },
  "Symbols Nerd Font Mono",
})
config.font_size = 18.0

config.term = "xterm-256color"
config.set_environment_variables = { COLORTERM = "truecolor" }
config.default_cursor_style = "BlinkingBlock"
config.scrollback_lines = 10000

config.window_background_opacity = 0.9
config.window_decorations = "TITLE | RESIZE"
config.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }

config.color_schemes = {
  ["Gruber Darker"] = {
    foreground = "#e4e4ef",
    background = "#181818",
    cursor_bg = "#e4e4ef",
    cursor_fg = "#181818",
    selection_bg = "#484848",
    ansi = { "#000000", "#f43841", "#73c936", "#ffdd33", "#5f627f", "#9e95c7", "#5f627f", "#ffffff" },
    brights = { "#282828", "#ff4f58", "#73c936", "#ffdd33", "#96a6c8", "#9e95c7", "#96a6c8", "#ffffff" },
  },
}
config.color_scheme = "Gruber Darker"

return config
