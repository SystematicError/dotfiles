local awful = require "awful"
local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

local current_date

local function weekday_widget(weekday)
    return {
        text = weekday,
        halign = "center",
        font = beautiful.calendar_font,
        widget = wibox.widget.textbox,
    }
end

local function day_widget(day)
    return {
        text = day,
        halign = "center",
        font = beautiful.calendar_font,
        widget = wibox.widget.textbox,
    }
end

local function current_day_widget(day)
    return {
        {
            markup = string.format('<span foreground="%s">%s</span>', beautiful.calendar_bg, day),
            halign = "center",
            font = beautiful.calendar_current_font,
            widget = wibox.widget.textbox,
        },

        shape = gears.shape.circle,
        bg = beautiful.calendar_current,
        widget = wibox.container.background
    }
end

local function weekend_day_widget(day)
    return {
        markup = string.format('<span foreground="%s">%s</span>', beautiful.calendar_weekend, day),
        halign = "center",
        font = beautiful.calendar_font,
        widget = wibox.widget.textbox,
    }
end

local title = wibox.widget {
    font = beautiful.calendar_header_font,
    widget = wibox.widget.textbox
}

local grid = wibox.widget {
    forced_num_rows = 6,
    forced_num_cols = 7,
    vertical_spacing = dpi(10),
    horizontal_spacing = dpi(15),
    min_cols_size = dpi(40),
    min_rows_size = dpi(40),
    homogenous = true,
    layout = wibox.layout.grid,
}

local function update_calendar(date)
    title.text = os.date("%B %Y", os.time(date))

    grid:reset()

    for _, weekday in ipairs {"Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"} do
        grid:add(weekday_widget(weekday))
    end

    local first_date = os.date("*t", os.time({day = 1, month = date.month, year = date.year}))
    local last_date = os.date("*t", os.time({day = 0, month = date.month + 1, year = date.year}))

    local row = 2
    local col = first_date.wday

    for day = 1, last_date.day do
        if day == date.day and os.date("*t").month == date.month then
            grid:add_widget_at(current_day_widget(day), row, col)
        elseif col == 1 or col == 7 then
            grid:add_widget_at(weekend_day_widget(day), row, col)
        else
            grid:add_widget_at(day_widget(day), row, col)
        end

        if col == 7 then
            col = 1
            row = row + 1
        else
            col = col + 1
        end
    end
end

local calendar = awful.popup {
    widget = {
        -- Header
        {
            {
                -- Month and year
                {
                    title,

                    margins = dpi(15),
                    widget = wibox.container.margin
                },

                nil,

                -- Buttons
                {
                    {
                        {
                            {
                                -- Back
                                {
                                    image = beautiful.calendar_back,

                                    buttons = {
                                        awful.button({}, 1, function()
                                            current_date = os.date("*t", os.time({
                                                day = current_date.day,
                                                month = current_date.month - 1,
                                                year = current_date.year
                                            }))
                                            update_calendar(current_date)
                                        end)
                                    },

                                    widget = wibox.widget.imagebox
                                },


                                -- Next
                                {
                                    image = beautiful.calendar_next,

                                    buttons = {
                                        awful.button({}, 1, function()
                                            current_date = os.date("*t", os.time({
                                                day = current_date.day,
                                                month = current_date.month + 1,
                                                year = current_date.year
                                            }))
                                            update_calendar(current_date)
                                        end)
                                    },

                                    widget = wibox.widget.imagebox
                                },

                                layout = wibox.layout.fixed.horizontal
                            },

                            height = dpi(30),
                            widget = wibox.container.constraint
                        },

                        right = dpi(5),
                        widget = wibox.container.margin
                    },

                    valign = "center",
                    widget = wibox.container.place
                },

                layout = wibox.layout.align.horizontal
            },

            bg = beautiful.calendar_header_bg,
            fg = beautiful.calendar_header_fg,
            widget = wibox.container.background
        },

        -- Body
        {
            grid,

            margins = dpi(15),
            widget = wibox.container.margin
        },

        layout = wibox.layout.fixed.vertical
    },

    ontop = true,
    visible = false,

    bg = beautiful.calendar_bg,
    fg = beautiful.calendar_fg,

    border_color = beautiful.border_color,
    border_width = dpi(1),

    placement = function(drawable)
        awful.placement.top(drawable, {
            honor_workarea = true,
            margins = beautiful.useless_gap * 2
        })
    end
}

return function()
    calendar.visible = not calendar.visible

    if calendar.visible then
        current_date = os.date("*t")
        update_calendar(current_date)
    end
end
