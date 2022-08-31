-- DISCLAIMER: I cannot guarantee the security of your device
-- when using this lock, use at your own risk!

local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local naughty = require "naughty"
local wibox = require "wibox"

local pam = require "liblua_pam"
local utils = require "module.utils"
local power = require "module.power"

local dpi = beautiful.xresources.apply_dpi

local username = os.getenv("USER"):gsub("^%l", string.upper)

-- 2 widgets are used to prevent an infinite loop whilst redrawing
local prompt_input = wibox.widget {widget = wibox.widget.textbox}
local password_box = wibox.widget {
    {
        font = beautiful.lock_password_text_font,
        widget = wibox.widget.textbox
    },

    fg = beautiful.lock_password_placeholder_color,
    widget = wibox.container.background
}

-- Hide the password while its being typed
prompt_input:connect_signal("widget::redraw_needed", function()
    if #prompt_input.text < 2 then
        password_box.fg = beautiful.lock_password_placeholder_color
        password_box.children[1].text = "Enter password here..."
    else
        password_box.fg = beautiful.lock_password_text_color
        password_box.children[1].text = string.rep(" ", #prompt_input.text - 1)
    end
end)

-- TODO: Make time greeting update
local time_greeting = wibox.widget {
    text = "Good\nDay",
    valign = "top",
    font = beautiful.lock_splash_text_font,
    widget = wibox.widget.textbox
}

local backdrop = awful.popup {
    widget = {
        {
            image = beautiful.wallpaper_blur,
            widget = wibox.widget.imagebox
        },

        width = awful.screen.focused().geometry.width,
        height = awful.screen.focused().geometry.height,
        strategy = "exact",
        widget = wibox.container.constraint
    },

    ontop = true,
    visible = false
}

local function power_button(icon, name, action)
    local widget = utils.hover_bg_transition {
        widget = utils.button_cursor {
            {
                {
                    {
                        -- Icon
                        {
                            {
                                image = icon,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(20),
                            widget = wibox.container.constraint
                        },

                        -- Name
                        {
                            text = name,
                            font = beautiful.lock_powermenu_text_font,
                            widget = wibox.widget.textbox
                        },

                        spacing = dpi(15),
                        layout = wibox.layout.fixed.horizontal
                    },

                    halign = "center",
                    widget = wibox.container.place
                },

                margins = dpi(12),
                widget = wibox.container.margin
            },

            buttons = {
                -- Wrapped in an anonymous function to prevent arguments being passed
                awful.button({}, 1, function() action() end)
            },

            fg = beautiful.lock_powermenu_text_color,
            bg = beautiful.lock_input_color,
            shape = gears.shape.rounded_rect,
            widget = wibox.container.background,
        },

        original_color = beautiful.lock_input_color,
        hover_color = beautiful.lock_input_hover_color
    }

    return widget
end

local popup = awful.popup {
    widget = {
        -- Left side
        {
            -- Splash image
            {
                {
                    image = beautiful.lock_splash_image,
                    widget = wibox.widget.imagebox
                },

                width = dpi(350),
                height = dpi(500),
                strategy = "exact",
                widget = wibox.container.constraint
            },

            -- Time greeting
            {
                {
                    time_greeting,

                    fg = beautiful.lock_splash_text_color,
                    widget = wibox.container.background
                },

                top = dpi(10),
                left = dpi(25),
                widget = wibox.container.margin
            },

            layout = wibox.layout.stack
        },

        -- Right side
        {
            {
                {
                    -- Top section, basic info
                    {
                        {
                            -- Profile picture
                            {
                                {
                                    image = beautiful.profile_pic,
                                    clip_shape = gears.shape.circle,
                                    widget = wibox.widget.imagebox
                                },

                                width = dpi(45),
                                strategy = "exact",
                                widget = wibox.container.constraint
                            },

                            -- Username
                            {
                                {
                                    text = username,
                                    valign = "center",
                                    font = beautiful.lock_username_text_font,
                                    widget = wibox.widget.textbox
                                },

                                fg = beautiful.lock_username_text_color,
                                widget = wibox.container.background
                            },

                            spacing = dpi(10),
                            layout = wibox.layout.fixed.horizontal
                        },

                        -- Lock icon
                        {
                            {
                                image = beautiful.lock_icon,
                                valign = "center",
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(22),
                            widget = wibox.container.constraint
                        },

                        spacing = dpi(300),
                        layout = wibox.layout.fixed.horizontal
                    },

                    -- Middle section, password input
                    {
                        utils.text_cursor {
                            {
                                password_box,

                                margins = dpi(10),
                                widget = wibox.container.margin
                            },

                            bg = beautiful.lock_input_color,
                            shape = gears.shape.rounded_rect,
                            widget = wibox.container.background
                        },

                        height = dpi(40),
                        strategy = "exact",
                        widget = wibox.container.constraint
                    },

                    -- Bottom section, power options
                    {
                        power_button(beautiful.power_shutdown_icon, "Shutdown", power.shutdown),
                        power_button(beautiful.power_sleep_icon, "Sleep", power.sleep),
                        power_button(beautiful.power_quit_icon, "Log out", awesome.quit),

                        spacing = dpi(20),
                        layout = wibox.layout.flex.horizontal,
                    },

                    spacing = dpi(25),
                    layout = wibox.layout.fixed.vertical
                },

                valign = "center",
                widget = wibox.container.place
            },

            margins = dpi(20),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.horizontal
    },

    ontop = true,
    visible = false,
    bg = beautiful.lock_background_color,
    placement = awful.placement.centered
}

local function grab_password(callback)
    prompt_input:emit_signal("widget::redraw_needed")

    awful.prompt.run {
        textbox = prompt_input,

        -- Prevent the input prompt from crashing / cancelling
        hooks = {
            {{}, "Escape", function() grab_password(callback) end},
            {{"Control"}, "c", function() grab_password(callback) end},
            {{"Control"}, "r", function() grab_password(callback) end},
            {{"Control"}, "s", function() grab_password(callback) end},
            {{"Control"}, "Up", function() grab_password(callback) end},
            {{"Control"}, "Down", function() grab_password(callback) end},
            {{"Control"}, "Delete", function() grab_password(callback) end}
        },

        exe_callback = callback,
    }
end

local function verify_password(password)
    -- return password == "testing"
    return pam.auth_current_user(password)
end

local function lock()
    local current_hour = tonumber(os.date("%H"))

    if current_hour < 3 then
        time_greeting.text = "Good\nNight"

    elseif current_hour < 12 then
        time_greeting.text = "Good\nMorning"

    elseif current_hour < 16 then
        time_greeting.text = "Good\nAfternoon"

    elseif current_hour < 21 then
        time_greeting.text = "Good\nEvening"

    else
        time_greeting.text = "Good\nNight"
    end

    backdrop.visible = true
    popup.visible = true

    grab_password(function(password)
        if verify_password(password) then
            backdrop.visible = false
            popup.visible = false

        else
            naughty.notification {
                app_name = "Screen Locker",
                app_icon = beautiful.lock_icon,
                title = "Authentication Failed",
                message = "The password entered was incorrect"
            }

            lock()
        end
    end)
end

return lock
