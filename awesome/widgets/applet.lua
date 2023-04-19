local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

local slide = require "module.slide"

local toggle_state = false

local toggle_circle = wibox.widget {
    {
        {
            bg = "#0a1a1a",
            shape = gears.shape.circle,
            widget = wibox.container.background
        },

        height = dpi(16),
        width = dpi(16),
        strategy = "exact",
        widget = wibox.container.constraint
    },

    valign = "true",
    widget = wibox.container.place,
}

local toggle_bg = wibox.widget {
    {
        toggle_circle,

        top = dpi(2),
        bottom = dpi(2),
        left = dpi(3),
        right = dpi(3),
        widget = wibox.container.margin
    },

    shape = gears.shape.rounded_bar,
    widget = wibox.container.background
}

local function set_toggle_state(enabled)
    toggle_circle.halign = enabled and "right" or "left"
    toggle_bg.bg = enabled and "#5ac87b" or "#505050"
end

local toggle = wibox.widget {
    toggle_bg,

    buttons = {
        awful.button({}, 1, function()
            toggle_state = not toggle_state
            set_toggle_state(toggle_state)
        end)
    },

    height = dpi(20),
    width = dpi(40),
    strategy = "exact",
    widget = wibox.container.constraint
}

local title = wibox.widget {
    font = "Inter 13",
    widget = wibox.widget.textbox
}

local applet = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    title,

                    nil,
                    toggle,

                    layout = wibox.layout.align.horizontal
                },

                margins = dpi(15),
                widget = wibox.container.margin
            },

            bg = "#1a1a1a",
            fg = "#717171",
            widget = wibox.container.background
        },

        -- Body
        {
            {
                spacing = dpi(15),
                layout = wibox.layout.fixed.vertical
            },

            margins = dpi(15),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    ontop = true,
    visible = false,

    minimum_width = dpi(500),
    maximum_width = dpi(500),

    bg = "#0f0f0f",
    fg = "#ffffff",

    border_color = beautiful.border_color,
    border_width = dpi(1),

    placement = function(drawable)
        awful.placement.top_right(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
}

applet.visible = true
set_toggle_state(true)
title.text = "Applet"

