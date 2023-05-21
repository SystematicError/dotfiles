local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local slide = require "module.slide"

local powermenu = require "widgets.power"
local stateicon = require "widgets.stateicon"

local dpi = beautiful.xresources.apply_dpi

local uptime = wibox.widget {
    font = beautiful.dashboard_uptime_font,
    widget = wibox.widget.textbox
}

local function toggle(icon, text, action, active)
    return {
        -- Icon
        {
            {
                {
                    icon,
                    width = dpi(20),
                    widget = wibox.container.constraint
                },

                margins = dpi(12),
                widget = wibox.container.margin
            },

            bg = active and "#1b68ac" or "#303030",
            shape = gears.shape.circle,
            widget = wibox.container.background
        },

        {
            -- Text
            {
                text = text,
                font = "Inter Medium 12",

                buttons = {
                    awful.button({}, 1, function()
                        awesome.emit_signal("dashboard::hide", action)
                    end),
                },

                widget = wibox.widget.textbox
            },

            -- Status
            {
                markup = string.format('<span foreground="%s">%s</span>', beautiful.dashboard_header_fg, active and "On" or "Off"),
                font = "Inter 12",
                widget = wibox.widget.textbox
            },

            layout = wibox.layout.fixed.vertical
        },

        spacing = dpi(10),
        layout = wibox.layout.fixed.horizontal
    }
end

local function button(icon, text)
    return {
        {
            {
                {
                    -- Icon
                    {
                        {
                            icon,
                            width = dpi(25),
                            widget = wibox.container.constraint
                        },

                        valign = "center",
                        widget = wibox.container.place
                    },

                    -- Text
                    {
                        text = text,
                        font = "Inter Medium 13",
                        widget = wibox.widget.textbox
                    },

                    spacing = dpi(8),
                    layout = wibox.layout.fixed.horizontal
                },

                halign = "center",
                widget = wibox.container.place
            },

            margins = dpi(12),
            widget = wibox.container.margin
        },

        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height)
        end,

        bg = "#1a1a1a",
        widget = wibox.container.background
    }
end

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
                                    text = beautiful.username,
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

        -- Body
        {
            {
                -- Applets
                {
                    -- Left
                    {
                        {
                            {
                                toggle(stateicon.network, "Network", function(), true),
                                toggle(stateicon.bluetooth, "Bluetooth", function(), false),
                                toggle(stateicon.notification, "Notifications", function(), false),

                                spacing = dpi(15),
                                layout = wibox.layout.fixed.vertical
                            },

                            margins = dpi(15),
                            widget = wibox.container.margin
                        },

                        shape = function(cr, width, height)
                            gears.shape.rounded_rect(cr, width, height, dpi(8))
                        end,

                        bg = "#1a1a1a",
                        widget = wibox.container.background
                    },

                    -- Right
                    {
                        button(stateicon.sink, "Audio Mixer"),
                        button(wibox.widget.imagebox(beautiful.screenshot), "Screenshot"),

                        spacing = dpi(20),
                        layout = wibox.layout.flex.vertical
                    },

                    spacing = dpi(20),
                    layout = wibox.layout.flex.horizontal
                },

                spacing = dpi(20),
                layout = wibox.layout.fixed.vertical
            },

            margins = dpi(20),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    ontop = true,
    visible = false,

    minimum_width = dpi(500),
    maximum_width = dpi(500),

    bg = beautiful.dashboard_bg,
    fg = beautiful.dashboard_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    placement = function(drawable)
        awful.placement.top_right(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
}

awesome.connect_signal("dashboard::hide", function(action)
    slide.toggle(dashboard, slide.path.from_top, action)
end)

return function()
    if not dashboard.visible then
        local seconds
        local uptime_file = io.open("/proc/uptime", "r")

        if uptime_file then
            seconds = uptime_file:read("a")
            uptime_file:close()

            seconds = seconds:match("(%d+)%.")

            if tonumber(seconds) < 60 then
                uptime.markup = "Just now"
            else
                local hours = math.floor(seconds / 60 / 60) .. "h "
                hours = hours == "0h " and "" or hours
                local minutes = math.floor(seconds / 60 % 60) .. "min"

                uptime.markup = hours..minutes
            end

            uptime.markup = string.format('<span foreground="%s">%s</span>', beautiful.dashboard_header_fg, uptime.markup)
        end
    end

    slide.toggle(dashboard, slide.path.from_top)
end

