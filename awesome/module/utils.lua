local gears = require "gears"
local lgi = require "lgi"
local rubato = require "module.rubato"

local module = {}

-- TODO: Make these custom widgets

local function hover_cursor(widget, cursor)
	widget:connect_signal("mouse::enter", function()
		if mouse.current_wibox then
			mouse.current_wibox.cursor = cursor
		end
	end)

	widget:connect_signal("mouse::leave", function()
		if mouse.current_wibox then
			mouse.current_wibox.cursor = "left_ptr"
		end
	end)

	return widget
end

function module.button_cursor(widget)
	return hover_cursor(widget, "hand2")
end

function module.text_cursor(widget)
	return hover_cursor(widget, "xterm")
end

function module.hover_bg_transition(widget, original_color, hover_color)
	local r1, b1, g1 = gears.color.parse_color(original_color)
	local r2, b2, g2 = gears.color.parse_color(hover_color)

	local transition = rubato.timed {
		intro = 0.1,
		duration = 0.25,
		subscribed = function(value)
			-- Transition logic from https://www.niwa.nu/2013/05/math-behind-colorspace-conversions-rgb-hsl/
			local r = math.min(math.max(r1 + value * (r2 - r1), 0), 255)
			local b = math.min(math.max(b1 + value * (b2 - b1), 0), 255)
			local g = math.min(math.max(g1 + value * (g2 - g1), 0), 255)

			widget.bg = lgi.cairo.Pattern.create_rgba(r, g, b, 1)
		end
	}

	widget:connect_signal("mouse::enter", function()
		transition.target = 1
	end)

	widget:connect_signal("mouse::leave", function()
		transition.target = 0
	end)

	return widget
end

return module