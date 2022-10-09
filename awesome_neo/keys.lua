local awful = require "awful"

-- Quick way to return anonymous functions for executing commands
local function spawn(process)
    return function() awful.spawn(process) end
end

local super = "Mod4"
local alt = "Mod1"

local apps = {
    browser = "firefox",
    terminal = "wezterm",
    text_editor = "wezterm start nvim",
    file_manager = "wezterm start xplr",
    resource_monitor = "wezterm start btop"
}

-- General keybinds
awful.keyboard.append_global_keybindings {
    -- Power / WM control
    awful.key({super, alt}, "r", awesome.restart),

    -- Apps
    awful.key({super}, "Return", spawn(apps.terminal)),
    awful.key({super, "Shift"}, "f", spawn(apps.browser)),
    awful.key({super, "Shift"}, "x", spawn(apps.file_manager)),
    awful.key({super, "Shift"}, "n", spawn(apps.text_editor)),
    awful.key({super, "Shift"}, "b", spawn(apps.resource_monitor)),

    -- Change tag layout
    awful.key({super}, "t", function() awful.layout.inc(1) end),
    awful.key({super, "Shift"}, "t", function() awful.layout.inc(-1) end),

    -- Switch tags
    awful.key {
        modifiers = {super},
        keygroup = "numrow",
        on_press = function(index)
            local t = awful.screen.focused().tags[index]
            if t then t:view_only() end
        end,
    },
}

-- Keybinds for client control
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings {
        -- Close client
        awful.key({super}, "x", function(c) c:kill() end),

        -- Toggle floating
        awful.key({super}, "f", function(c)
            if not c.fullscreen then
                c.floating = not c.floating
            end
        end),

        -- Toggle fullscreen
        awful.key({super}, "s", function(c)
            c.fullscreen = not c.fullscreen
        end),

        -- Move client to tag
        awful.key {
            modifiers = {super, "Shift"},
            keygroup = "numrow",
            on_press = function(index, c)
                local t = awful.screen.focused().tags[index]
                if t then c:move_to_tag(t) end
            end,
        },

        -- Move client to tag and switch to it
        awful.key {
            modifiers = {super, "Control"},
            keygroup = "numrow",
            on_press = function(index, c)
                local t = awful.screen.focused().tags[index]
                if t then
                    c:move_to_tag(t)
                    t:view_only()
                end
            end,
        },
    }
end)

-- Mouse actions for clients
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings {
        awful.button({}, 1, function(c)
            c:activate {context = "mouse_click"}
        end),

        awful.button({super}, 1, function(c)
            c:activate {context = "mouse_click", action = "mouse_move"}
        end),

        awful.button({super}, 3, function(c)
            c:activate {context = "mouse_click", action = "mouse_resize"}
        end)
    }
end)

