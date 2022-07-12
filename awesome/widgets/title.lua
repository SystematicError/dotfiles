local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

awful.titlebar.enable_tooltip = false
awful.titlebar.fallback_name = "New Window"

-- Window titlebars
client.connect_signal("request::titlebars", function(c)
    local buttons = {
        awful.button({}, 1, function() c:activate {context = "titlebar", action = "mouse_move"} end),
        awful.button({}, 3, function() c:activate {context = "titlebar", action = "mouse_resize"} end)
    }

    awful.titlebar(c, {
        size = dpi(30),
        font = beautiful.titlebar_font,

        bg_normal = beautiful.titlebar_bg,
        bg_focus = beautiful.titlebar_bg,
        bg_urgent = beautiful.titlebar_bg,
    }):setup {
        nil,

        -- Title
        {
            {
                align = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },

            buttons = buttons,
            layout = wibox.layout.flex.horizontal
        },

        -- Buttons
        {
            {
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.floatingbutton(c),
                awful.titlebar.widget.closebutton(c),

                spacing = dpi(2),
                layout = wibox.layout.fixed.horizontal,
            },

            margins = dpi(8),
            widget = wibox.container.margin
        },

        layout = wibox.layout.align.horizontal,
    }
end)

-- Apply titlebars only to floating windows
client.connect_signal("property::floating", function(c)
    if c.floating and not (c.requests_no_titlebar or c.fullscreen) then
        awful.titlebar.show(c)
    else
        awful.titlebar.hide(c)
    end

    if c.fullscreen then return end

    if c.floating then
        c.above = true
    else
        c.above = false
    end
end)

