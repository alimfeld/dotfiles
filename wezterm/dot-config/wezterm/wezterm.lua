local wezterm = require("wezterm")

local config = wezterm.config_builder()

local shell = "/opt/homebrew/bin/fish"

config.default_prog = { shell, "-l" }
config.set_environment_variables = {
    SHELL = shell,
}
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 14

config.keys = {
    {
        key = 'f',
        mods = 'CTRL|SHIFT',
        action = wezterm.action.ToggleFullScreen
    },
    {
        key = "Enter",
        mods = "ALT",
        action = wezterm.action.DisableDefaultAssignment,
    },
}

config.color_scheme = 'tokyonight'

return config
