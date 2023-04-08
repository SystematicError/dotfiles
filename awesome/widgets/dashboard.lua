local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

awful.popup {
    widget = {
        text = "Hello World",
        widget = wibox.widget.textbox
    },

    ontop = true,
    visible = true,

    bg = beautiful.calendar_bg,
    fg = beautiful.calendar_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    placement = function(drawable)
        awful.placement.top_right(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
}

