local dpi = require("beautiful.xresources").apply_dpi
local assets = require("gears.filesystem").get_configuration_dir() .. "assets/"

local theme = {}

theme.wallpaper = assets .. "general/wallpaper.jpg"
theme.wallpaper_blur = assets .. "general/wallpaper_blur.jpg"

theme.useless_gap = dpi(6)

theme.popup_font = "Inter Medium 13"
theme.popup_bg = "#0f0f0f"
theme.popup_fg = "#ffffff"
theme.popup_bar_bg = "#2b2b2b"
theme.popup_bar_fg = "#5ac87b"

return theme
