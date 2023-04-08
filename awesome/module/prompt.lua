local awful = require "awful"
local wibox = require "wibox"

return function(args)
    local text = ""
    local cursor = 0

    args.textbox.text = args.prompt or ""

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

            elseif key == "Right" then
                cursor = math.min(text:wlen(), cursor + 1)

            elseif key:wlen() == 1 then
                text = text:sub(0, cursor) .. key .. text:sub(cursor + 1)
                cursor = cursor + 1
            end

            if text == "" then
                args.textbox.text = args.prompt or ""
            else
                -- TODO: Proper cursor rendering
                -- args.textbox.text = text
                args.textbox.text = text:sub(0, cursor).. "|" .. text:sub(cursor + 1)
            end

            if args.on_press then
                args.on_press(text)
            end
        end,

        stop_callback = function(_, stop_key)
            args.textbox.text = args.prompt or ""
            args.on_done(text, stop_key ~= "Return")
        end
    }
end



