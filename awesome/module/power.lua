local awful = require "awful"

local module = {}

function module.shutdown()
    awful.spawn("loginctl poweroff", false)
end

function module.restart()
    awful.spawn("loginctl reboot", false)
end

function module.hibernate()
    awful.spawn("loginctl hibernate", false)
end

function module.sleep()
    awful.spawn("loginctl suspend", false)
end

return module
