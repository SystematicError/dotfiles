-- TODO: Multi monitor support

local awful = require "awful"
local beautiful = require "beautiful"

local config_dir = require("gears.filesystem").get_configuration_dir()

-- This is needed to import .so libraries into lua code
package.cpath = package.cpath .. ";" .. config_dir .. "module/?.so;"

beautiful.init(config_dir .. "theme.lua")

require "signals"
require "keys"
require "rules"
require "widgets"

-- Prevent windows from loosing focus when switching tags
require "awful.autofocus"

-- Make windows "blink" when focus is changed
require "module.flash_focus"

awful.spawn(config_dir .. "startup.sh", false)

