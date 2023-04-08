local awful = require "awful"
local beautiful = require "beautiful"
local wibox = require "wibox"

return awful.popup {
    widget = {
        image = beautiful.wallpaper_blur,
        widget = wibox.widget.imagebox
    },

    maximum_width = awful.screen.focused().geometry.width,
    maximum_height = awful.screen.focused().geometry.height,

    ontop = true,
    visible = false
}
