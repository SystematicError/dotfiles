local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local slide = require "module.slide"

-- TODO: Gtk 4
local Gio = require("lgi").Gio
local Gtk = require("lgi").Gtk

local fzy = require "module.fzy"
local prompt = require "module.prompt"

local dpi = beautiful.xresources.apply_dpi

local apps = {}

for _, app in ipairs(Gio.AppInfo.get_all()) do
    if app:should_show() then
        table.insert(apps, {
            name = app:get_name(),
            icon = Gtk.IconTheme.get_default():lookup_by_gicon(app:get_icon(), 48, 0):get_filename(),
            launch = function() app:launch() end
        })
    end
end

local search = wibox.widget {
    font = beautiful.launcher_header_font,
    text = "Search for an app...",
    widget = wibox.widget.textbox
}

local app_list = wibox.widget {
    spacing = dpi(15),
    layout = wibox.layout.fixed.vertical
}

local empty = wibox.widget {
    {
        {
            -- Icon
            {
                {
                    {
                        image = beautiful.launcher_empty_icon,
                        widget = wibox.widget.imagebox
                    },

                    width = dpi(40),
                    widget = wibox.container.constraint
                },

                halign = "center",
                widget = wibox.container.place
            },

            -- Text
            {
                markup = '<span foreground="' .. beautiful.launcher_empty_fg .. '">Nothing was found</span>',
                font = beautiful.launcher_font,
                widget = wibox.widget.textbox
            },

            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical
        },

        valign = "center",
        widget = wibox.container.place
    },

    height = dpi(250),
    strategy = "exact",
    widget = wibox.container.constraint
}

local launcher = awful.popup {
    widget = {
        -- Header
        {
            {
                {
                    -- Prompt
                    search,

                    nil,

                    -- Icon
                    {
                        {
                            image = beautiful.launcher_search_icon,
                            widget = wibox.widget.imagebox
                        },

                        height = dpi(22),
                        widget = wibox.container.constraint
                    },


                    layout = wibox.layout.align.horizontal
                },

                margins = dpi(15),
                widget = wibox.container.margin
            },

            bg = beautiful.launcher_header_bg,
            fg = beautiful.launcher_header_fg,
            widget = wibox.container.background
        },

        -- Body
        {
            {
                app_list,
                empty,

                layout = wibox.layout.fixed.vertical
            },

            margins = dpi(15),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    minimum_width = dpi(560),
    maximum_width = dpi(560),

    bg = beautiful.launcher_bg,
    fg = beautiful.launcher_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    visible = false,
    ontop = true,

    placement = function(drawable)
        awful.placement.top_left(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end

}

local function update_results(text)
    app_list.children = {}

    if text == "" then
        empty.visible = true
        return
    end

    local results = fzy.filter(text, gears.table.map(function(app)
        return app.name
    end, apps))

    for _, app in ipairs(results) do
        if #app_list.children == 6 then break end

        app = apps[app[1]]

        table.insert(app_list.children, wibox.widget {
            -- Icon
            {
                {
                    image = app.icon,
                    widget = wibox.widget.imagebox
                },

                height = dpi(40),
                widget = wibox.container.constraint
            },

            -- Name
            {
                text = app.name,
                font = beautiful.launcher_font,
                widget = wibox.widget.textbox
            },

            buttons = {
                awful.button({}, 1, app.launch)
            },

            spacing = dpi(15),
            layout = wibox.layout.fixed.horizontal
        })
    end

    empty.visible = #app_list.children == 0
end

return function()
    app_list.children = {}

    slide.toggle(launcher, function()
        prompt {
            textbox = search,
            cursor_color = beautiful.launcher_header_fg,
            placeholder = "Search for an app...",

            on_press = function(text)
                update_results(text)
            end,

            on_done = function(_, cancelled)
                slide.outro(launcher, function()
                    empty.visible = true
                end)

                if #app_list.children > 0 and not cancelled then
                    print(app_list.children[1].buttons[1]:trigger())
                end
            end
        }
    end)
end
