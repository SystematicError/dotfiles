local ruled = require "ruled"

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule {
        rule = {
            class = "firefox",
            name = "Picture-in-Picture"
        },
        properties = {sticky = true}
    }
end)

