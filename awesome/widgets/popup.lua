local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local rubato = require "module.rubato"
local utils = require "module.utils"

local dpi = beautiful.xresources.apply_dpi

local popup_name = wibox.widget {
    font = beautiful.popup_text_font,
    widget = wibox.widget.textbox
}

local popup_percent = wibox.widget {
    align = "right",
    font = beautiful.popup_text_font,
    widget = wibox.widget.textbox
}

local popup_icon = wibox.widget {
    id = "icon",
    widget = wibox.widget.imagebox,
}

local popup_bar = wibox.widget {
    maximum = 100,

    bar_height = dpi(3),
    bar_color = beautiful.popup_bar_color,
    bar_shape = gears.shape.rounded_rect,

    handle_width = dpi(12),
    handle_shape = gears.shape.circle,

    widget = wibox.widget.slider
}

local popup = awful.popup {
    widget = {
        {
            -- Top
            {
                popup_name,
                popup_percent,

                layout = wibox.layout.align.horizontal
            },

            -- Bottom
            {
                -- Icon
                {
                    {
                        popup_icon,

                        width = 25,
                        widget = wibox.container.constraint
                    },

                    margins = dpi(3),
                    widget = wibox.container.margin
                },

                -- Slider bar
                {
                    popup_bar,

                    height = dpi(12),
                    width = dpi(200),
                    widget = wibox.container.constraint
                },

                spacing = dpi(10),
                layout = wibox.layout.fixed.horizontal
            },

            spacing = dpi(10),
            layout = wibox.layout.fixed.vertical
        },

        margins = 20,
        widget = wibox.container.margin
    },

    ontop = true,
    visible = false,
    input_passthrough = true,
    fg = beautiful.popup_text_color,
    bg = beautiful.popup_bg_color,

    -- Horizontally center the popup and position it 3/4 down vertically
    placement = function(drawable)
        awful.placement.centered(drawable, {
            offset = {y = drawable.screen.geometry.height * 0.25}
        })
    end
}

local animated_bar = rubato.timed {
    intro = 0.1,
    duration = 0.25,
    subscribed = function(value)
        popup_bar.value = value
    end
}

-- Timer to auto hide popup
local timer = gears.timer {
    timeout = 2,
    single_shot = true,

    callback = function()
        popup.visible = false
    end
}

local function show_popup()
    if not popup.visible then
        popup.visible = true
    end
    timer:again()
end

awesome.connect_signal("brightness_change", function(brightness)
    popup_name.text = "Brightness"
    popup_percent.text = brightness .. "%"
    animated_bar.target = brightness

    -- Set bar color
    popup_bar.handle_color = beautiful.popup_normal_color
    popup_bar.bar_active_color = beautiful.popup_normal_color

    -- Determine icon
    if brightness < 50 then
        popup_icon.image = beautiful.brightness_low
    else
        popup_icon.image = beautiful.brightness_high
    end

    show_popup()
end)

awesome.connect_signal("volume_change", function(device, volume, mute)
    popup_name.text = "Volume"
    popup_percent.text = volume .. "%"

    -- Determine bar color
    if volume > 100 then
        animated_bar.target = volume - 100
        popup_bar.handle_color = beautiful.popup_overflow_color
        popup_bar.bar_active_color = beautiful.popup_overflow_color
    else
        animated_bar.target = volume
        popup_bar.handle_color = beautiful.popup_normal_color
        popup_bar.bar_active_color = beautiful.popup_normal_color
    end

    popup_icon.image = utils.iconify_volume(device, volume, mute)

    show_popup()
end)

