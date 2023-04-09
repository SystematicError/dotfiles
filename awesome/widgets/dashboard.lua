local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local powermenu = require "widgets.power"

local dpi = beautiful.xresources.apply_dpi

local uptime = wibox.widget {
    font = beautiful.dashboard_uptime_font,
    widget = wibox.widget.textbox
}

local dashboard = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    {
                        -- Profile pic
                        {
                            {
                                image = beautiful.profile_pic,
                                clip_shape = gears.shape.circle,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(64),
                            widget = wibox.container.constraint
                        },

                        {
                            {
                                -- Username
                                {
                                    markup = string.format(
                                        '<span foreground="%s">%s</span>',
                                        beautiful.dashboard_fg,
                                        beautiful.username
                                    ),
                                    font = beautiful.dashboard_username_font,
                                    widget = wibox.widget.textbox
                                },

                                -- Uptime
                                uptime,

                                layout = wibox.layout.fixed.vertical
                            },

                            valign = "center",
                            widget = wibox.container.place
                        },

                        spacing = dpi(12),
                        layout = wibox.layout.fixed.horizontal
                    },

                    nil,

                    -- Exit
                    {
                        {
                            {
                                image = beautiful.power_exit,

                                buttons = {
                                    awful.button({}, 1, powermenu)
                                },

                                widget = wibox.widget.imagebox
                            },

                            width = dpi(24),
                            widget = wibox.container.constraint
                        },

                        valign = "center",
                        widget = wibox.container.place
                    },

                    layout = wibox.layout.align.horizontal
                },

                margins = dpi(20),
                widget = wibox.container.margin
            },

            bg = beautiful.dashboard_header_bg,
            widget = wibox.container.background
        },

        layout = wibox.layout.fixed.vertical
    },

    ontop = true,
    visible = false,

    minimum_width = dpi(510),

    bg = beautiful.dashboard_bg,
    fg = beautiful.dashboard_header_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    placement = function(drawable)
        awful.placement.top_right(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
}

local function toggle()
    dashboard.visible = not dashboard.visible

    if not dashboard.visible then return end

    local seconds
    local uptime_file = io.open("/proc/uptime", "r")

    if uptime_file then
        seconds = uptime_file:read("a")
        uptime_file:close()

        seconds = seconds:match("(%d+)%.")

        local hours = math.floor(seconds / 60 / 60) .. "h "
        hours = hours == "0h " and "" or hours
        local minutes = math.floor(seconds / 60 % 60) .. "min"

        uptime.text = hours..minutes
    end
end

toggle()

