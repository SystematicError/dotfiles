local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local prompt = require "module.prompt"

local blur = require "widgets.blur"

local dpi = beautiful.xresources.apply_dpi

local entry_box = wibox.widget {
    font = "Inter 13",
    widget = wibox.widget.textbox
}

local menu = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    text = "Login",
                    font = "Inter 13",
                    widget = wibox.widget.textbox
                },

                margins = dpi(15),
                widget = wibox.container.margin
            },

            fg = "#717171",
            bg = "#1a1a1a",
            widget = wibox.container.background
        },

        -- Body
        {
            {
                {
                    -- Profile pic
                    {
                        {
                            {
                                image = beautiful.profile_pic,
                                clip_shape = gears.shape.circle,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(45),
                            widget = wibox.container.constraint
                        },

                        halign = "center",
                        widget = wibox.container.place
                    },

                    -- Username
                    {
                        text = beautiful.username,
                        valign = "center",
                        font = "Inter Medium 16",
                        widget = wibox.widget.textbox
                    },

                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal
                },

                -- Password box
                {
                    {
                        {
                            entry_box,

                            width = dpi(450),
                            strategy = "exact",
                            widget = wibox.container.constraint
                        },

                        margins = dpi(15),
                        widget = wibox.container.margin
                    },

                    shape = function(cr, width, height)
                        gears.shape.rounded_rect(cr, width, height, dpi(8))
                    end,

                    fg = "#717171",
                    bg = "#1a1a1a",
                    widget = wibox.container.background
                },

                spacing = dpi(20),
                layout = wibox.layout.fixed.vertical
            },

            margins = dpi(50),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    bg = "#0f0f0f",
    fg = "#ffffff",

    border_width = dpi(1),
    border_color = beautiful.border_color,

    ontop = true,
    visible = false,

    placement = awful.placement.centered
}

local function authenticate(on_done)
    prompt {
        textbox = entry_box,
        censor = true,
        cursor_color = "#717171",
        placeholder = "Enter the password...",

        on_done = function(password, cancelled)
            -- Temporary password for debugging
            if not cancelled and password == "password" then
                on_done()
            else
                authenticate(on_done)
            end
        end,
    }
end

return function()
    blur.visible = true
    menu.visible = true

    authenticate(function()
        blur.visible = false
        menu.visible = false
    end)
end

