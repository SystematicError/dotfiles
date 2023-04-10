local beautiful = require "beautiful"
local wibox = require "wibox"

local icon = {}

icon.sink = wibox.widget {
    image = beautiful.volume_sink_high,
    widget = wibox.widget.imagebox
}

icon.source = wibox.widget {
    image = beautiful.volume_source_normal,
    widget = wibox.widget.imagebox
}

icon.network = wibox.widget {
    image = beautiful.network,
    widget = wibox.widget.imagebox
}

icon.bluetooth = wibox.widget {
    image = beautiful.bluetooth,
    widget = wibox.widget.imagebox
}

icon.notification = wibox.widget {
    image = beautiful.notification,
    widget = wibox.widget.imagebox
}

return icon
