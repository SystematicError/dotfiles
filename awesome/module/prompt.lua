local awful = require "awful"
local gears = require "gears"

local Pango = require("lgi").Pango

-- TODO: Handle multibyte strings properly

return function(args)
    local text = ""
    local cursor = 0
    local draw_cursor = false

    args.textbox.text = args.placeholder or ""

    local _draw = args.textbox.draw

    -- Cursor drawing logic adapted from KwesomeDE
    function args.textbox:draw(context, cr, width, height)
        _draw(args.textbox, context, cr, width, height)

        local _, dimensions = args.textbox._private.layout:get_pixel_extents()

        local cursor_pos = math.max(0, (args.textbox._private.layout:get_cursor_pos(cursor).x / Pango.SCALE) - 1)

        if draw_cursor then
            cr:set_source(gears.color(args.cursor_color or "#ffffff"))
            cr:set_line_width(1)
            cr:move_to(cursor_pos, - 3)
            cr:line_to(cursor_pos, dimensions.height + 6)
            cr:stroke()
        end
    end

    awful.keygrabber {
        autostart = true,
        stop_key = {"Escape", "Return"},

        keypressed_callback = function(_, _, key)
            if key == "Escape" or key == "Return" then return end

            if key == "BackSpace" then
                text = text:sub(0, math.max(0, cursor - 1)) .. text:sub(cursor + 1, -1)
                cursor = math.max(0, cursor - 1)

            elseif key == "Delete" then
                text = text:sub(0, cursor) .. text:sub(cursor + 2, -1)

            elseif key == "Left" then
                cursor = math.max(0, cursor - 1)
                args.textbox:emit_signal("widget::redraw_needed")

            elseif key == "Right" then
                cursor = math.min(text:wlen(), cursor + 1)
                args.textbox:emit_signal("widget::redraw_needed")

            elseif key:wlen() == 1 then
                text = text:sub(0, cursor) .. key .. text:sub(cursor + 1)
                cursor = cursor + 1
            end

            if text == "" then
                args.textbox.text = args.placeholder or ""
                draw_cursor = false
            else
                draw_cursor = true
                local display_text = text

                if args.censor then
                    display_text = ("●"):rep(text:wlen())
                end

                args.textbox.text = display_text
            end

            if args.on_press then
                args.on_press(text)
            end
        end,

        stop_callback = function(_, stop_key)
            args.textbox.text = args.placeholder or ""
            draw_cursor = false
            args.on_done(text, stop_key ~= "Return")
        end
    }
end



