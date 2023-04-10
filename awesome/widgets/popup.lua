local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local stateicon = require "widgets.stateicon"

local dpi = beautiful.xresources.apply_dpi

local label = wibox.widget {
    font = beautiful.popup_header_font,
    widget = wibox.widget.textbox
}

local percentage = wibox.widget {
    font = beautiful.popup_header_font,
    widget = wibox.widget.textbox
}

local icon

local bar = wibox.widget {
    border_width = 0,
    forced_height = dpi(8),

    shape =  gears.shape.rounded_bar,
    bar_shape =  gears.shape.rounded_bar,

    background_color = beautiful.popup_bar_bg,

    widget = wibox.widget.progressbar
}

label.text = "Volume"
percentage.text = "60%"
icon = stateicon.sink
bar.value = 0.6
bar.color = beautiful.popup_bar_sink

awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    -- Left side
                    label,

                    nil,

                    -- Right side
                    percentage,

                    layout = wibox.layout.align.horizontal
                },

                margins = dpi(12),
                widget = wibox.container.margin
            },

            bg = beautiful.popup_header_bg,
            fg = beautiful.popup_header_fg,
            widget = wibox.container.background
        },

        -- Body
        {
            {
                -- Icon
                {
                    icon,

                    width = dpi(40),
                    widget = wibox.container.constraint
                },

                -- Progress bar
                {
                    bar,

                    top = dpi(16),
                    bottom = dpi(16),
                    widget = wibox.container.margin
                },

                spacing = dpi(12),
                layout = wibox.layout.fixed.horizontal
            },

            margins = dpi(12),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    maximum_width = dpi(360),

    bg = beautiful.popup_bg,
    fg = beautiful.popup_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    ontop = true,
    visible = true,

    -- Center horizontally and offset it downwards vertically
    placement = function(drawable)
        awful.placement.centered(drawable, {
            offset = {y = drawable.screen.geometry.height * 0.2}
        })
    end
}
