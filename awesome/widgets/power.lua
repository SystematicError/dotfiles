local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local power = require "module.power"
local utils = require "module.utils"

local lockscreen = require "widgets.lock"

local dpi = beautiful.xresources.apply_dpi

-- Blurred background
local backdrop = awful.popup {
    widget = {
        {
            image = beautiful.wallpaper_blur,
            widget = wibox.widget.imagebox
        },

        buttons = {
            awful.button({}, 1, function()
                awesome.emit_signal("powermenu_close")
            end)
        },

        width = awful.screen.focused().geometry.width,
        height = awful.screen.focused().geometry.height,
        strategy = "exact",
        widget = wibox.container.constraint
    },

    ontop = true,
    visible = false
}

local placeholder_info = "Chose wisely, " .. os.getenv("USER"):gsub("^%l", string.upper) .. "!"

local info_text = wibox.widget {
    text = placeholder_info,
    font = beautiful.power_info_text_font,
    widget = wibox.widget.textbox
}

local function powerbutton(icon, action, info)
    local widget = wibox.widget {
        {
            {
                {
                    image = icon,
                    widget = wibox.widget.imagebox
                },


                margins = dpi(20),
                widget = wibox.container.margin
            },

            width = dpi(90),
            strategy = "exact",
            widget = wibox.container.constraint
        },

        buttons = {
            awful.button({}, 1, function()
                awesome.emit_signal("powermenu_close")
                action()
            end)
        },

        bg = beautiful.power_button_color,
        shape = gears.shape.rounded_rect,
        widget = wibox.container.background
    }

    utils.button_cursor(widget)
    utils.hover_bg_transition(widget, beautiful.power_button_color, beautiful.power_button_hover_color)

    widget:connect_signal("mouse::enter", function()
        info_text.text = info
    end)

    return widget
end

local powermenu = awful.popup {
    widget = {
        {
            info_text,

            {
                powerbutton(beautiful.power_shutdown_icon, power.shutdown, "Shutdown"),
                powerbutton(beautiful.power_restart_icon, power.restart, "Restart"),
                powerbutton(beautiful.power_sleep_icon, power.sleep, "Sleep"),
                powerbutton(beautiful.power_hibernate_icon, power.hibernate, "Hibernate"),
                powerbutton(beautiful.lock_icon, lockscreen, "Lock"),
                powerbutton(beautiful.power_quit_icon, awesome.quit, "Log out"),

                spacing = dpi(20),
                layout = wibox.layout.fixed.horizontal
            },

            spacing = dpi(20),
            layout = wibox.layout.fixed.vertical
        },

        margins = dpi(20),
        widget = wibox.container.margin
    },

    ontop = true,
    visible = false,
    fg = beautiful.power_info_text_color,
    bg = beautiful.power_background_color,
    placement = awful.placement.centered
}

powermenu:connect_signal("mouse::leave", function()
    info_text.text = placeholder_info
end)

return function()
    info_text.text = placeholder_info

    -- Hide menu when escape is pressed
    local keygrabber = awful.keygrabber {
        autostart = true,
        stop_key = "Escape",

        start_callback = function()
            backdrop.visible = true
            powermenu.visible = true
        end,

        stop_callback = function()
            backdrop.visible = false
            powermenu.visible = false
        end
    }

    awesome.connect_signal("powermenu_close", function()
        keygrabber:stop()
    end)
end

