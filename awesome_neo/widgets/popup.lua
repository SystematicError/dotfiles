local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

local icon = {
    widget = wibox.widget.imagebox
}

local label = {
    font = beautiful.popup_font,
    widget = wibox.widget.textbox
}

local percent = {
    font = beautiful.popup_font,
    widget = wibox.widget.textbox
}

local bar = {
    value = 75,
    max_value = 100,

    color = beautiful.popup_bar_fg,
    background_color = beautiful.popup_bar_bg,

    shape = gears.shape.rounded_bar,
    bar_shape = gears.shape.rounded_bar,

    widget = wibox.widget.progressbar
}

label.text = "Volume"
percent.text = "70%"
icon.image = "/home/systematic/Dotfiles/awesome_neo/assets/volume/sink_high.svg"

local popup = awful.popup {
    widget = {
        {
            -- Icon
            {
                icon,

                width = dpi(45),
                height = dpi(45),
                widget = wibox.container.constraint
            },

            {
                {
                    -- Text
                    {
                        label,
                        nil,
                        percent,

                        layout = wibox.layout.align.horizontal
                    },

                    -- Bar
                    {
                        bar,

                        width = dpi(200),
                        height = dpi(8),
                        widget = wibox.container.constraint
                    },

                    spacing = dpi(8),
                    layout = wibox.layout.fixed.vertical
                },

                valign = "center",
                widget = wibox.container.place
            },

            spacing = dpi(15),
            layout = wibox.layout.fixed.horizontal
        },

        margins = dpi(20),
        widget = wibox.container.margin
    },

    ontop = true,
    visible = false,
    bg = beautiful.popup_bg,
    fg = beautiful.popup_fg,

    -- Horizontally center the popup and position it 3/4 down vertically
    placement = function(drawable)
        awful.placement.centered(drawable, {
            offset = {y = drawable.screen.geometry.height * 0.25}
        })
    end
}

