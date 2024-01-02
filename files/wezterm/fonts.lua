local wezterm = require "wezterm"
local config = {}

config.font = wezterm.font "JetBrainsMono NF"
config.font_size = 15.0
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.harfbuzz_features = {
    "zero", -- Use a slashed zero '0' (instead of dotted)
    "kern", -- (default) kerning (todo check what is really is)
    "liga", -- (default) ligatures
    "clig", -- (default) contextual ligatures
}

return config
