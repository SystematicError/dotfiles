local wezterm = require "wezterm"

wezterm.on("format-window-title", function()
    return "Wezterm"
end)

return {
    xcursor_theme = "capitaine-cursors",
    bold_brightens_ansi_colors = false,
    hide_tab_bar_if_only_one_tab = true,

    font = wezterm.font_with_fallback {
        "JetBrainsMono Nerd Font",
        "Twemoji"
    },

    window_padding = {
        left = 35,
        right = 35,
        top = 35,
        bottom = 35
    },

    colors = {
        foreground = "#bababa",
        background = "#0f0f0f",

        cursor_fg = "#0f0f0f",
        cursor_bg = "#bababa",
        cursor_border = "#909090",

        selection_fg = "#bababa",
        selection_bg = "#181818",

        ansi = {
            "#1e1e1e",
            "#fc4e4e",
            "#bbef6e",
            "#ffaf60",
            "#6aa4cc",
            "#8d8bc4",
            "#96e0c9",
            "#cdcdcd"
        },

        brights = {
            "#404040",
            "#ff6565",
            "#c5ec8e",
            "#f6cd7e",
            "#82b4d6",
            "#ac9dcc",
            "#b8e5ec",
            "#e8e8e8"
        }
    }
}
