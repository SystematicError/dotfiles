-- A really really minimal config, fallback if
-- there is a critical error in the main config

local awful = require "awful"
local beautiful = require "beautiful"

beautiful.init {
    useless_gap = 6,
    background_color = "#161718",

    terminal_app = "wezterm",
    browser_app = "firefox"
}

require "awful.autofocus"

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5"}, s, awful.layout.suit.tile)
end)

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper {
        screen = s,
        bg = beautiful.background_color
    }
end)

awful.keyboard.append_global_keybindings {
    awful.key({"Mod4", "Mod1"}, "q", awesome.quit),
    awful.key({"Mod4", "Mod1"}, "r", awesome.restart),

    awful.key({"Mod4"}, "Return", function() awful.spawn(beautiful.terminal_app) end),
    awful.key({"Mod4", "Shift"}, "f", function() awful.spawn(beautiful.browser_app) end),

    awful.key {
        modifiers = {"Mod4"},
        keygroup = "numrow",
        on_press = function(index)
            local tag = awful.screen.focused().tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },

    awful.key {
        modifiers = {"Mod4", "Shift"},
        keygroup = "numrow",
        on_press = function(index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
}

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        awful.key({"Mod4"}, "x", function(c) c:kill() end),
        awful.key({"Mod4"}, "f", function(c) c.floating = not c.floating end),
        awful.key({"Mod4"}, "s", function(c) c.fullscreen = not c.fullscreen end)
    }
end)

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings {
        awful.button({}, 1, function(c) c:activate {context = "mouse_click"} end),
        awful.button({"Mod4"}, 1, function(c) c:activate {context = "mouse_click", action = "mouse_move"} end),
        awful.button({"Mod4"}, 3, function(c) c:activate {context = "mouse_click", action = "mouse_resize"} end)
    }
end)
