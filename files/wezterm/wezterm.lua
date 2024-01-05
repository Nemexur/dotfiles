local wezterm = require("wezterm")

local function update(cfg, c)
    for k, v in pairs(c) do
        cfg[k] = v
    end
end

local config = {}
if wezterm.config_builder then
    config = wezterm.config_builder()
end
update(config, require("appearance"))
update(config, require("fonts"))

return config
