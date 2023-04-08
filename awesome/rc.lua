local config_dir = require("gears.filesystem").get_configuration_dir()

require("beautiful").init(config_dir .. "theme.lua")

require "core"
require "keys"
require "rules"
require "widgets"

-- require("awful").spawn(config_dir .. "startup.sh", false)
