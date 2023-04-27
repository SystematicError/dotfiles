local applet = require "widgets.applet"

return function()
    applet.title.text = "Notification Center"
    applet.toggle_visibility()
end
