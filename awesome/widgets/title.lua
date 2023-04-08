local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

awful.titlebar.enable_tooltip = false
awful.titlebar.fallback_name = "New Window"

client.connect_signal("request::titlebars", function(c)
    awful.titlebar(c, {
        size = dpi(35),
        font = beautiful.titlebar_font,
    }):setup {
        {
            -- Icon
            {
                awful.titlebar.widget.iconwidget(c),

                height = dpi(18),
                widget = wibox.container.constraint
            },

            -- Title
            awful.titlebar.widget.titlewidget(c),

            spacing = dpi(4),
            layout = wibox.layout.fixed.horizontal
        },

        margins = dpi(8),
        widget = wibox.container.margin
    }
end)

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
