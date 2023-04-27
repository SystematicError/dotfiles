local applet = require "widgets.applet"

return function()
    applet.title.text = "Network"
    applet.toggle_visibility()
end
