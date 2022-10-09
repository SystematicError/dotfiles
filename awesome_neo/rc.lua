local config_dir = require("gears.filesystem").get_configuration_dir()

require("beautiful").init(config_dir .. "theme.lua")

-- Prevents focus from being lost when switching workspaces
require "awful.autofocus"

require "core"
require "keys"
require "rules"

require("awful").spawn(config_dir .. "startup.sh", false)
