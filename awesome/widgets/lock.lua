local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"

local prompt = require "module.prompt"

local blur = require "widgets.blur"

local dpi = beautiful.xresources.apply_dpi

local entry_box = wibox.widget.textbox()

local menu = awful.popup {
    widget = {
        entry_box,

        margins = dpi(15),
        widget = wibox.container.margin
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
        cursor_color = "#ffffff",
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

