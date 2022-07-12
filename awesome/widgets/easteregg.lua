local awful = require "awful"
local wibox = require "wibox"

local dpi = require("beautiful").xresources.apply_dpi

awful.popup {
    widget = {
        {
            {
                text = "Activate Windows",
                font = "Segoe UI 20",
                widget = wibox.widget.textbox
            },

            {
                text = "Go to Settings to activate Windows.",
                font = "Segoe UI 15",
                widget = wibox.widget.textbox
            },

            layout = wibox.layout.fixed.vertical
        },

        margins = dpi(30),
        widget = wibox.container.margin
    },

    opacity = 0.35,
    fg = "#ffffff",
    bg = "#00000000",

    placement = awful.placement.bottom_right,

    type = "desktop",
    ontop = true,
    input_passthrough = true
}

