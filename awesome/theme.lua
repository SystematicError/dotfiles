local dpi = require("beautiful.xresources").apply_dpi
local assets = require("gears.filesystem").get_configuration_dir() .. "assets/"

local theme = {}

local core = {
    font = "Inter",
    fg = "#ffffff",
    bg = "#0f0f0f",
    alt_bg = "#1a1a1a",
    alt_fg = "#717171",
    border = "#202020"
}

theme.useless_gap = dpi(6)
theme.font = core.font

theme.border_width = dpi(1)
theme.border_color = core.border

theme.logo = assets .. "general/logo.svg"

theme.wallpaper = assets .. "general/wallpaper.jpg"
theme.wallpaper_blur = assets .. "general/wallpaper_blur.jpg"

theme.username = "Systematic"
theme.profile_pic = assets .. "general/profile_pic.png"

theme.wibar_bg = core.bg
theme.wibar_height = dpi(40)

theme.taglist_focused = "#3178b9"
theme.taglist_occupied = "#717171"
theme.taglist_empty = "#353535"

theme.clock_font = core.font .. " Medium 12"

theme.battery_normal_bg = "#466851"
theme.battery_normal_fg = "#5ac87b"
theme.battery_low_bg = "#775b3e"
theme.battery_low_fg = "#ffaf60"
theme.battery_critical_bg = "#7a403b"
theme.battery_critical_fg = "#ef6258"
theme.battery_charging = assets .. "battery/charging.svg"
theme.battery_font = core.font .. " SemiBold"

theme.titlebar_bg = core.alt_bg
theme.titlebar_fg = core.alt_fg
theme.titlebar_font = core.font .. " 12"

theme.popup_bg = core.bg
theme.popup_fg = core.fg
theme.popup_header_bg = core.alt_bg
theme.popup_header_fg = core.alt_fg
theme.popup_bar_sink = "#5ac87b"
theme.popup_bar_source = "#ef7067"
theme.popup_bar_brightness = "#ffaf60"
theme.popup_bar_bg = "#242424"
theme.popup_header_font = core.font .. " 12"

theme.volume_sink_low = assets .. "volume/sink_low.svg"
theme.volume_sink_high = assets .. "volume/sink_high.svg"
theme.volume_sink_mute = assets .. "volume/sink_mute.svg"
theme.volume_source_normal = assets .. "volume/source_normal.svg"
theme.volume_source_mute = assets .. "volume/source_mute.svg"

theme.brightness = assets .. "brightness/icon.svg"

theme.power_bg = core.bg
theme.power_header_bg = core.alt_bg
theme.power_header_fg = core.alt_fg
theme.power_button_bg = core.alt_bg
theme.power_shutdown = assets .. "power/shutdown.svg"
theme.power_restart = assets .. "power/restart.svg"
theme.power_sleep = assets .. "power/sleep.svg"
theme.power_hibernate = assets .. "power/hibernate.svg"
theme.power_exit = assets .. "power/exit.svg"
theme.power_header_font = core.font .. " 13"

theme.launcher_bg = core.bg
theme.launcher_fg = core.fg
theme.launcher_header_bg = core.alt_bg
theme.launcher_header_fg = core.alt_fg
theme.launcher_empty_fg = core.alt_fg
theme.launcher_font = core.font .. " 12"
theme.launcher_header_font = core.font .. " 13"
theme.launcher_search_icon = assets .. "launcher/search.svg"
theme.launcher_empty_icon = assets .. "launcher/empty.svg"

theme.calendar_bg = core.bg
theme.calendar_fg = core.fg
theme.calendar_header_bg = core.alt_bg
theme.calendar_header_fg = core.alt_fg
theme.calendar_current = "#6bb3db"
theme.calendar_weekend = core.alt_fg
theme.calendar_font = core.font .. " 14"
theme.calendar_current_font = core.font .. " SemiBold 14"
theme.calendar_header_font = core.font .. " 13"
theme.calendar_next = assets .. "calendar/next.svg"
theme.calendar_back = assets .. "calendar/back.svg"

theme.dashboard_bg = core.bg
theme.dashboard_fg = core.fg
theme.dashboard_header_bg = core.alt_bg
theme.dashboard_header_fg = core.alt_fg
theme.dashboard_username_font = core.font .. " Medium 14"
theme.dashboard_uptime_font = core.font .. " 12"
theme.dashboard_icon = assets .. "dashboard/icon.svg"

theme.lock_icon = assets .. "lock/icon.svg"
theme.network = assets .. "network/icon.svg"
theme.bluetooth = assets .. "bluetooth/icon.svg"
theme.notification = assets .. "notification/icon.svg"
theme.screenshot = assets .. "screenshot/icon.svg"

return theme
