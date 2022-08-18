-- TODO: Urgency levels
-- TODO: Resident notifications
-- TODO: Notification buttons

local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local menubar = require "menubar"
local naughty = require "naughty"
local wibox = require "wibox"

local rubato = require "module.rubato"

local dpi = beautiful.xresources.apply_dpi

naughty.config.defaults.app_name = "Notification"

naughty.connect_signal("request::display", function(notification)
    local notification_image

    -- Display image if provided
    if notification.image then
        notification_image = {
            {
                {
                    image = notification.image,
                    valign = "center",
                    clip_shape = function(context, width, height)
                        gears.shape.rounded_rect(context, width, height, 3)
                    end,
                    widget = wibox.widget.imagebox,
                },

                height = dpi(40),
                strategy = "exact",
                widget = wibox.container.constraint
            },

            width = dpi(100),
            widget = wibox.container.constraint
        }
    end

    local app_icon =
        -- Use image path as icon if it exists
        gears.filesystem.file_readable(notification.app_icon or "") and notification.app_icon or

        -- XDG icon lookup
        menubar.utils.lookup_icon(notification.app_icon or notification.app_name) or
        menubar.utils.lookup_icon((notification.app_icon or notification.app_name):lower()) or

        -- Fallback icon
        beautiful.notification_app_icon

    local widget_template = wibox.widget {
        {
            -- Titlebar
            {
                {
                    -- Left side
                    {
                        -- App icon
                        {
                            {
                                image = app_icon,
                                valign = "center",
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(16),
                            height = dpi(16),
                            strategy = "exact",
                            widget = wibox.container.constraint,
                        },

                        -- App name
                        {
                            text = notification.app_name,
                            valign = "center",
                            font = beautiful.notification_titlebar_text_font,
                            widget = wibox.widget.textbox
                        },

                        spacing = dpi(5),
                        layout = wibox.layout.fixed.horizontal
                    },

                    -- Right side
                    {
                        text = os.date("%l:%M %p"),
                        align = "right",
                        font = beautiful.notification_titlebar_text_font,
                        widget = wibox.widget.textbox
                    },

                    layout = wibox.layout.align.horizontal
                },

                margins = dpi(10),
                widget = wibox.container.margin
            },

            fg = beautiful.notification_titlebar_text_color,
            bg = beautiful.notification_titlebar_color,
            widget = wibox.container.background
        },

        -- Timeout bar
        {
            {
                id = "timeout_bar",

                color = beautiful.notification_timeout_foreground_color,
                background_color = beautiful.notification_timeout_background_color,

                value = notification.timeout,
                max_value = notification.timeout,

                widget = wibox.widget.progressbar
            },

            height = dpi(2),
            widget = wibox.container.constraint
        },

        {
            {
                {
                    -- Content
                    {
                        notification_image,

                        {
                            -- Title
                            {
                                {
                                    text = notification.title,
                                    visible = notification.title,
                                    font = beautiful.notification_title_text_font,
                                    widget = wibox.widget.textbox
                                },

                                fg = beautiful.notification_title_text_color,
                                widget = wibox.container.background
                            },

                            -- Description
                            {
                                {
                                    text = notification.message,
                                    visible = notification.message,
                                    font = beautiful.notification_description_text_font,
                                    widget = wibox.widget.textbox,
                                },

                                fg = beautiful.notification_description_text_color,
                                widget = wibox.container.background
                            },

                            spacing = dpi(5),
                            layout = wibox.layout.fixed.vertical
                        },

                        spacing = dpi(15),
                        layout = wibox.layout.fixed.horizontal
                    },

                    -- Action buttons
                    {
                        notification = notification,
                        widget = naughty.list.actions
                    },

                    layout = wibox.layout.fixed.vertical
                },

                margins = dpi(15),
                widget = wibox.container.margin
            },

            bg = beautiful.notification_background_color,
            widget = wibox.container.background
        },

        layout = wibox.layout.fixed.vertical
    }

    local timeout_bar = widget_template:get_children_by_id("timeout_bar")[1]

    local timeout_animation = rubato.timed {
        duration = notification.timeout,
        pos = notification.timeout,

        easing = rubato.linear,

        subscribed = function(value)
            timeout_bar.value = value
        end
    }

    local last_position
    local destroyed = false

    -- Pause notification timeout when hovering
    widget_template:connect_signal("mouse::enter", function()
        if destroyed then return end

        -- HACK: This should be set to 0 but that feature is broken
        notification.timeout = 9999

        last_position = timeout_animation.pos
        timeout_animation.pause = true
    end)

    -- Resume timeout
    widget_template:connect_signal("mouse::leave", function()
        if destroyed or not last_position then return end

        notification.timeout = last_position
        timeout_animation.pause = false
    end)

    -- Disable mouse signals from triggering
    notification:connect_signal("destroyed", function()
        destroyed = true
        timeout_animation:abort()
    end)

    -- Start timeout progressbar animation
    timeout_animation.target = 0

    -- Display notification
    naughty.layout.box {
        notification = notification,
        widget_template = widget_template,

        border_width = 0,
        minimum_width = dpi(300),
        maximum_width = dpi(300),
        maximum_height = dpi(300),

        placement = awful.placement.bottom_right
    }
end)

