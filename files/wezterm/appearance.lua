local colors = require("colors")

local config = {}


config.color_scheme = "Dracula+"
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.80
config.macos_window_background_blur = 8
config.max_fps = 120
config.scrollback_lines = 15000
config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.6,
}

return config
