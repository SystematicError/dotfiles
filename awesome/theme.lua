-- TODO: Text theme colors

local dpi = require("beautiful.xresources").apply_dpi
local assets = require("gears.filesystem").get_configuration_dir() .. "assets/"

local theme = {}

-- Core
theme.border_width  = 0
theme.useless_gap   = dpi(6)

theme.font = "Poppins 8"
theme.icon_theme = "/usr/share/icons/la-capitaine"
awesome.set_preferred_icon_size(40)

theme.enable_easter_egg = false

-- General assets
theme.logo = assets .. "logo.svg"
theme.profile_pic = assets .. "profile_pic.png"

theme.wallpaper = assets .. "wallpaper.jpg"
theme.wallpaper_blur = assets .. "wallpaper_blur.jpg"

-- Titlebar
theme.titlebar_bg = "#131313"
theme.titlebar_fg_focus = "#dddddd"
theme.titlebar_fg_normal = "#505050"
theme.titlebar_fg_urgent = "#ff0000"

theme.titlebar_font = "Poppins 9"

theme.titlebar_sticky_button_focus_active  = assets .. "title/stuck.svg"
theme.titlebar_sticky_button_normal_active = assets .. "title/stuck_dim.svg"
theme.titlebar_sticky_button_focus_inactive  = assets .. "title/stick.svg"
theme.titlebar_sticky_button_focus_inactive_hover  = assets .. "title/stick_hover.svg"
theme.titlebar_sticky_button_normal_inactive = assets .. "title/dim.svg"
theme.titlebar_sticky_button_normal_inactive_hover = assets .. "title/stuck_dim.svg"

theme.titlebar_floating_button_focus_active  = assets .. "title/float.svg"
theme.titlebar_floating_button_focus_active_hover  = assets .. "title/float_hover.svg"
theme.titlebar_floating_button_focus_inactive  = assets .. "title/dim.svg"
theme.titlebar_floating_button_normal_active = assets .. "title/dim.svg"
theme.titlebar_floating_button_normal_active_hover = assets .. "title/float_dim_hover.svg"
theme.titlebar_floating_button_normal_inactive = assets .. "title/dim.svg"

theme.titlebar_close_button_focus = assets .. "title/close.svg"
theme.titlebar_close_button_focus_hover = assets .. "title/close_hover.svg"
theme.titlebar_close_button_normal = assets .. "title/dim.svg"
theme.titlebar_close_button_normal_hover = assets .. "title/close_dim_hover.svg"

-- Popups
theme.popup_bg_color = "#030303"
theme.popup_bar_color = "#202020"
theme.popup_normal_color = "#dddddd"
theme.popup_overflow_color = "#606060"

theme.popup_text_color = "#dddddd"
theme.popup_text_font = "Poppins 12"

theme.popup_brightness_low_icon = assets .. "brightness/low.svg"
theme.popup_brightness_high_icon = assets .. "brightness/high.svg"

theme.popup_sink_mute_icon = assets .. "volume/sink_mute.svg"
theme.popup_sink_low_icon = assets .. "volume/sink_low.svg"
theme.popup_sink_high_icon = assets .. "volume/sink_high.svg"

theme.popup_source_mute_icon = assets .. "volume/source_mute.svg"
theme.popup_source_normal_icon = assets .. "volume/source_normal.svg"

theme.popup_player_next_icon = assets .. "player/next.svg"
theme.popup_player_previous_icon = assets .. "player/previous.svg"
theme.popup_player_toggle_icon = assets .. "player/toggle.svg"

-- Notifications
theme.notification_background_color = "#030303"
theme.notification_timeout_foreground_color = "#3f769b"
theme.notification_timeout_background_color = "#0f0f0f"

theme.notification_titlebar_color = "#0a0a0a"
theme.notification_titlebar_text_color = "#eeeeee"
theme.notification_titlebar_text_font = "Poppins 9"

theme.notification_title_text_color = "#dddddd"
theme.notification_title_text_font = "Poppins SemiBold 10"

theme.notification_description_text_color = "#dddddd"
theme.notification_description_text_font = "Poppins 9"

theme.notification_app_icon = assets .. "notification/icon.svg"

-- Power menu
theme.power_background_color = "#0c0c0c"
theme.power_button_color = "#101010"
theme.power_button_hover_color = "#151515"
theme.power_info_text_color = "#dddddd"

theme.power_shutdown_icon = assets .. "power/shut_down.svg"
theme.power_restart_icon = assets .. "power/restart.svg"
theme.power_sleep_icon = assets .. "power/sleep.svg"
theme.power_hibernate_icon = assets .. "power/hibernate.svg"
theme.power_quit_icon = assets .. "power/quit.svg"

-- Lock screen
theme.lock_background_color = "#0c0c0c"
theme.lock_icon = assets .. "lock/lock.svg"

theme.lock_splash_image = assets .. "lock/splash.jpg"
theme.lock_splash_text_color = "#f5f5f5"
theme.lock_splash_text_font = "Poppins Bold 35"

theme.lock_input_color = "#101010"
theme.lock_button_hover_color = "#151515"

theme.lock_password_placeholder_color = "#808080"
theme.lock_password_text_color = "#dddddd"
theme.lock_password_text_font = "JetBrains Mono Nerd Font 10"

theme.lock_username_text_color = "#dddddd"
theme.lock_username_text_font = "Poppins 16"

theme.lock_powermenu_text_color = "#dddddd"
theme.lock_powermenu_text_font = "Poppins 10"

-- Screenshot utility
theme.screenshot_icon = assets .. "screenshot/icon.svg"

-- Bar
theme.wibar_bg = "#0f0f0f"
theme.wibar_fg = "#dddddd"
theme.wibar_height = dpi(35)

theme.taglist_active_color = "#c8c8c8"
theme.taglist_inactive_color = "#505050"
theme.taglist_font = "Poppins 10"

theme.clock_font = "Poppins Medium 11"

theme.layout_tile = assets .. "layout/tile.svg"
theme.layout_tilebottom = assets .. "layout/tile_bottom.svg"
theme.layout_fairv = assets .. "layout/fair.svg"
theme.layout_dwindle = assets .. "layout/spiral.svg"

return theme
