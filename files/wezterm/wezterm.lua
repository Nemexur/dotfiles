local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- Appearance
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
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true
config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}
-- Font
config.font = wezterm.font("JetBrainsMono NF")
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
