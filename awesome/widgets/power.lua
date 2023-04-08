local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local blur = require "widgets.blur"

local dpi = beautiful.xresources.apply_dpi

local function shutdown()
    awful.spawn("echo shutdown")
end

local function restart()
    awful.spawn("echo restart")
end

local function sleep()
    awful.spawn("echo sleep")
end

local function hibernate()
    awful.spawn("echo hibernate")
end

local function button(icon, action)
    return {
        {
            {
                {
                    image = icon,
                    widget = wibox.widget.imagebox
                },

                width = dpi(50),
                widget = wibox.container.constraint
            },

            margins = dpi(25),
            widget = wibox.container.margin
        },

        buttons = {
            awful.button({}, 1, action)
        },

        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, dpi(8))
        end,

        bg = beautiful.power_button_bg,
        widget = wibox.container.background
    }
end

local menu = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    text = "Powermenu",
                    font = beautiful.power_header_font,
                    widget = wibox.widget.textbox
                },

                margins = dpi(15),
                widget = wibox.container.margin
            },

            bg = beautiful.popup_header_bg,
            widget = wibox.container.background
        },

        -- Body
        {
            -- Buttons
            {
                button(beautiful.power_shutdown, shutdown),
                button(beautiful.power_restart, restart),
                button(beautiful.power_sleep, sleep),
                button(beautiful.power_hibernate, hibernate),
                button(beautiful.lock_icon, function() end),
                button(beautiful.power_exit, awesome.quit),

                spacing = dpi(30),
                layout = wibox.layout.fixed.horizontal
            },

            margins = dpi(30),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    bg = beautiful.power_bg,
    fg = beautiful.power_header_fg,

    border_width = dpi(1),
    border_color = beautiful.border_color,

    ontop = true,
    visible = false,

    placement = awful.placement.centered
}

return function()
    awful.keygrabber {
        autostart = true,
        stop_key = "Escape",

        start_callback = function()
            blur.visible = true
            menu.visible = true
        end,

        stop_callback = function()
            blur.visible = false
            menu.visible = false
        end
    }
end

