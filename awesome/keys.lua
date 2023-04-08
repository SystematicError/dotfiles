local awful = require "awful"

local launcher = require "widgets.launcher"
local powermenu = require "widgets.power"

-- Quick way to return anonymous functions for executing commands
local function spawn(process)
    return function() awful.spawn(process) end
end

-- local super = "Mod4"
local super = "Control"
local alt = "Mod1"

local apps = {
    browser = "firefox",
    terminal = "kitty -T=Terminal",
    -- terminal = "wezterm",
    text_editor = "wezterm start nvim",
    file_manager = "wezterm start xplr",
    resource_monitor = "wezterm start btop"
}

-- General keybinds
awful.keyboard.append_global_keybindings {
    awful.key({super}, "h", function() awful.spawn("xdotool mousemove_relative -- -5 0", false) end),
    awful.key({super}, "j", function() awful.spawn("xdotool mousemove_relative -- 0 5", false) end),
    awful.key({super}, "k", function() awful.spawn("xdotool mousemove_relative -- 0 -5", false) end),
    awful.key({super}, "l", function() awful.spawn("xdotool mousemove_relative -- 5 0", false) end),
    awful.key({super, "Shift"}, "h", function() awful.spawn("xdotool mousemove_relative -- -35 0", false) end),
    awful.key({super, "Shift"}, "j", function() awful.spawn("xdotool mousemove_relative -- 0 35", false) end),
    awful.key({super, "Shift"}, "k", function() awful.spawn("xdotool mousemove_relative -- 0 -35", false) end),
    awful.key({super, "Shift"}, "l", function() awful.spawn("xdotool mousemove_relative -- 35 0", false) end),
    awful.key({super, "Shift"}, "m", function() awful.spawn("xdotool click 1", false) end),

    awful.key({super, alt}, "r", awesome.restart),
    awful.key({super, alt}, "p", powermenu),

    awful.key({super}, "space", launcher),

    awful.key({super}, "Return", spawn(apps.terminal)),
    awful.key({super, "Shift"}, "f", spawn(apps.browser)),
    awful.key({super, "Shift"}, "x", spawn(apps.file_manager)),
    awful.key({super, "Shift"}, "n", spawn(apps.text_editor)),
    awful.key({super, "Shift"}, "b", spawn(apps.resource_monitor)),

    awful.key({super}, "Tab", function() awful.client.focus.byidx(1) end),
    awful.key({super, "Shift"}, "Tab", function() awful.client.focus.byidx(-1) end),

    awful.key({super}, "t", function() awful.layout.inc(1) end),
    awful.key({super, "Shift"}, "t", function() awful.layout.inc(-1) end),

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
        awful.key({super}, "x", function(c)
            c:kill()
        end),

        awful.key({super}, "f", function(c)
            if not c.fullscreen then
                c.floating = not c.floating
            end
        end),

        awful.key({super}, "s", function(c)
            c.fullscreen = not c.fullscreen
        end),

        awful.key {
            modifiers = {super, "Shift"},
            keygroup = "numrow",
            on_press = function(index, c)
                local t = awful.screen.focused().tags[index]
                if t then c:move_to_tag(t) end
            end,
        },

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
