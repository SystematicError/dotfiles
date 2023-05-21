local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local slide = require "module.slide"

local dpi = beautiful.xresources.apply_dpi

local applet = {}

applet.title = wibox.widget {
    font = "Inter 13",
    widget = wibox.widget.textbox,

    buttons = {
        awful.button({}, 1, function()
            applet.toggle_visibility(true)
        end)
    }
}

local toggle_circle = wibox.widget {
    {
        {
            bg = "#1a1a1a",
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


function applet.update_toggle_state()
    toggle_circle.halign = applet.toggle_state and "right" or "left"
    toggle_bg.bg = applet.toggle_state and "#5ac87b" or "#505050"
end

applet.toggle_state = false
applet.update_toggle_state()

local toggle = wibox.widget {
    toggle_bg,

    buttons = {
        awful.button({}, 1, function()
            applet.toggle_state = not applet.toggle_state
            applet.update_toggle_state()
        end)
    },

    height = dpi(20),
    width = dpi(40),
    strategy = "exact",
    widget = wibox.container.constraint
}

applet.body = wibox.widget {
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical
}

local popup = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    applet.title,

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
            applet.body,

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

function applet.toggle_visibility(hide)
    if not popup.visible or hide then
        slide.toggle(popup, slide.path.from_top)
    end
end

return applet

