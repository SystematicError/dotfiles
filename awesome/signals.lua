local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts {
        awful.layout.suit.tile,
        awful.layout.suit.tile.bottom,
        awful.layout.suit.fair,
        awful.layout.suit.spiral.dwindle,
    }
end)

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])
end)

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        widget = {
            image = beautiful.wallpaper,
            widget = wibox.widget.imagebox
        }
    }
end)

-- Arranges the windows a bit better
client.connect_signal("request::manage", function(c) awful.client.setslave(c) end)

-- Disable minimizing and maximizing
client.connect_signal("property::minimized", function(c) c.minimized = false end)
client.connect_signal("property::maximized", function(c) c.maximized = false end)

