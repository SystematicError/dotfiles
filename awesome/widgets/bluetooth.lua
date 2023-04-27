local applet = require "widgets.applet"

return function()
    applet.title.text = "Bluetooth"
    applet.toggle_visibility()
end
