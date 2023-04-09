local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local calendar = require "widgets.calendar"
local launcher = require "widgets.launcher"

local dpi = beautiful.xresources.apply_dpi

local logo = {
    image = beautiful.logo,

    buttons = {
        awful.button({}, 1, launcher)
    },

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

local battery = wibox.widget {
    {
        -- Progressbar
        {
            max_value = 100,

            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,

            bar_shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,

            widget = wibox.widget.progressbar
        },

        -- Percentage
        {
            valign = "center",
            halign = "center",

            font = beautiful.battery_font,

            widget = wibox.widget.textbox
        },

        -- Charging icon
        {
            {
                image = beautiful.battery_charging,
                widget = wibox.widget.imagebox
            },

            halign = "center",
            widget = wibox.container.place
        },

        widget = wibox.layout.stack
    },

    width = dpi(50),
    strategy = "exact",
    widget = wibox.container.constraint
}

local function update_battery(charge, charging)
    local battery_bar = battery.children[1].children[1]
    local battery_text = battery.children[1].children[2]
    local battery_icon = battery.children[1].children[3]

    battery_text.visible = not charging
    battery_icon.visible = charging

    battery_bar.value = charge
    battery_text.markup = string.format('<span foreground="%s">%d</span>', beautiful.wibar_bg, charge)

    if charge >= 20 or charging then
        battery_bar.color = beautiful.battery_normal_fg
        battery_bar.background_color = beautiful.battery_normal_bg
    elseif charge >= 10 then
        battery_bar.color = beautiful.battery_low_fg
        battery_bar.background_color = beautiful.battery_low_bg
    else
        battery_bar.color = beautiful.battery_critical_fg
        battery_bar.background_color = beautiful.battery_critical_bg
    end
end

update_battery(75, false)

local network = {
    image = beautiful.network,
    widget = wibox.widget.imagebox
}

local volume = {
    image = beautiful.volume_sink_high,
    widget = wibox.widget.imagebox
}

local dashboard = {
    image = beautiful.dashboard_icon,
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
                dashboard,
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
