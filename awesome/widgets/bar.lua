local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local calendar = require "widgets.calendar"

local dpi = beautiful.xresources.apply_dpi

local logo = {
    image = beautiful.logo,
    widget = wibox.widget.imagebox
}

local clock = {
    format = "%l:%M %p",
    font = beautiful.clock_font,

    buttons = {
        awful.button({}, 1, calendar)
    },

    widget = wibox.widget.textclock
}

local battery = {
    {
        {
            value = 0.75,

            color = beautiful.battery_normal_fg,
            background_color = beautiful.battery_normal_bg,

            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,

            bar_shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,

            widget = wibox.widget.progressbar
        },

        {
            markup = "<span color=\"" .. beautiful.wibar_bg .. "\">75</span>",
            font = beautiful.battery_font,

            valign = "center",
            halign = "center",

            widget = wibox.widget.textbox
        },

        widget = wibox.layout.stack
    },

    width = dpi(50),
    strategy = "exact",
    widget = wibox.container.constraint
}

local network = {
    image = beautiful.network,
    widget = wibox.widget.imagebox
}

local volume = {
    image = beautiful.volume_sink_high,
    widget = wibox.widget.imagebox
}

local menu = {
    image = beautiful.menu,
    widget = wibox.widget.imagebox
}

awful.screen.connect_for_each_screen(function(s)
    local bar = awful.wibar {position = "top"}

    local taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,

        layout   = {
            spacing = dpi(11),
            layout  = wibox.layout.fixed.horizontal
        },

        -- TODO: Buttons
        widget_template = {
            {
                shape = gears.shape.circle,
                widget = wibox.container.background
            },

            width = dpi(11),
            strategy = "exact",
            widget = wibox.container.constraint,

            create_callback = function(self, t)
                self:update_callback(t)
            end,

            update_callback = function(self, t)
                if t.selected then
                    self.children[1].bg = beautiful.taglist_focused
                elseif #t:clients() > 0 then
                    self.children[1].bg = beautiful.taglist_occupied
                else
                    self.children[1].bg = beautiful.taglist_empty
                end
            end
        }
    }

    local layout = awful.widget.layoutbox {
        screen = s
    }

    bar:setup {
        {
            -- Left
            {
                logo,
                taglist,

                spacing = dpi(11),
                layout = wibox.layout.fixed.horizontal
            },

            -- Center
            clock,

            -- Right
            {
                battery,
                network,
                volume,
                menu,
                layout,

                spacing = dpi(15),
                layout = wibox.layout.fixed.horizontal
            },

            expand = "none",
            layout = wibox.layout.align.horizontal
        },

        margins = dpi(10),
        widget = wibox.container.margin
    }
end)
