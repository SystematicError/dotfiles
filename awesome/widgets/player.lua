local beautiful = require "beautiful"
local gears = require "gears"
local wibox = require "wibox"

local dpi = beautiful.xresources.apply_dpi

local source = {
    font = "Inter Medium 11",
    valign = "center",
    widget = wibox.widget.textbox
}

local track = {
    font = "Inter SemiBold 24",
    widget = wibox.widget.textbox
}

local artist = {
    font = "Inter Medium 11",
    widget = wibox.widget.textbox
}

local duration = {
    font = "Inter Medium 11",
    widget = wibox.widget.textbox
}

source.markup = "<span foreground=\"#717171\">Now Playing ⋅ Spotify</span>"
track.text = "How It Feels"
artist.markup = "<span foreground=\"#717171\">by COIN</span>"
duration.text = "2:37"

return {
    {
        {
            {
                {
                    {
                        {
                            {
                                image = beautiful.player_note,
                                widget = wibox.widget.imagebox
                            },

                            height = dpi(16),
                            widget = wibox.container.constraint,
                        },

                        source,

                        spacing = dpi(2),
                        layout = wibox.layout.fixed.horizontal
                    },

                    track,
                    artist,

                    spacing = dpi(2),
                    layout = wibox.layout.fixed.vertical
                },

                nil,

                {
                    {
                        {
                            {
                                image = beautiful.player_back,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(24),
                            widget = wibox.container.constraint
                        },

                        {
                            {
                                image = beautiful.player_pause,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(24),
                            widget = wibox.container.constraint
                        },

                        {
                            {
                                image = beautiful.player_next,
                                widget = wibox.widget.imagebox
                            },

                            width = dpi(24),
                            widget = wibox.container.constraint
                        },

                        spacing = dpi(4),
                        layout = wibox.layout.fixed.horizontal
                    },

                    nil,

                    duration,

                    layout = wibox.layout.align.horizontal
                },

                layout = wibox.layout.align.vertical
            },

            margins = dpi(15),
            widget = wibox.container.margin
        },

        bg = "#1a1a1a",

        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height)
        end,

        widget = wibox.container.background
    },

    height = dpi(230),
    strategy = "exact",
    widget = wibox.container.constraint
}
