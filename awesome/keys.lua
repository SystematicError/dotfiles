-- TODO: Document keybinds
-- TODO: Add some more keybinds

local awful = require "awful"

local audio = require "module.audio"
local brightness = require "module.brightness"

local launcher = require "widgets.launcher"
local lockscreen = require "widgets.lock"
local powermenu = require "widgets.power"
local screenshot = require "widgets.screenshot"
local window_switcher = require "widgets.window_switcher"

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
    awful.key({super, alt}, "p", powermenu),
    awful.key({super, alt}, "l", lockscreen),

    -- Screenshot utility
    awful.key({}, "Print", screenshot.free),
    awful.key({"Shift"}, "Print", screenshot.client),
    awful.key({"Control"}, "Print", screenshot.screen),

    -- Application launcher
    awful.key({super}, "space", launcher),
    awful.key({}, "XF86Search", launcher),

    -- Window switcher
    awful.key({super}, "Tab", window_switcher),

    -- Apps
    awful.key({super}, "Return", spawn(apps.terminal)),
    awful.key({super, "Shift"}, "f", spawn(apps.browser)),
    awful.key({super, "Shift"}, "x", spawn(apps.file_manager)),
    awful.key({super, "Shift"}, "n", spawn(apps.text_editor)),
    awful.key({super, "Shift"}, "b", spawn(apps.resource_monitor)),

    -- Backlight
    awful.key({}, "XF86MonBrightnessUp", brightness.increase_brightness),
    awful.key({}, "XF86MonBrightnessDown", brightness.decrease_brightness),

    -- Audio
    awful.key({}, "XF86AudioMute", audio.toggle_sink_mute),
    awful.key({}, "XF86AudioRaiseVolume", audio.increase_sink_volume),
    awful.key({}, "XF86AudioLowerVolume", audio.decrease_sink_volume),

    awful.key({"Shift"}, "XF86AudioMute", audio.toggle_source_mute),
    awful.key({"Shift"}, "XF86AudioRaiseVolume", audio.increase_source_volume),
    awful.key({"Shift"}, "XF86AudioLowerVolume", audio.decrease_source_volume),

    -- Media playback
    -- TODO: Add player stuff
    awful.key({}, "XF86AudioNext", function() end),
    awful.key({}, "XF86AudioPrev", function() end),
    awful.key({}, "XF86AudioPlay", function() end),

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

