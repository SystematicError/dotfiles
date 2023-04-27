local wibox = require "wibox"
local cairo = require("lgi").cairo

local rubato = require "module.rubato"

local module = {path = {}}

-- Patched version of wibox.widget.draw_to_image_surface to accept fg and bg variables
local function draw_to_image_surface(wdg, width, height, format, context, bg, fg)
    local img = cairo.ImageSurface(format or cairo.Format.ARGB32, width, height)
    local cr = cairo.Context(img)

    cr:set_source(bg)
    cr:paint()

    cr:set_source(fg)

    wibox.widget.draw_to_cairo_context(wdg, cr, width, height, context)
    return img
end

function module.path.top_down(popup, reverse)
    return {
        from = reverse and popup.y or -popup.height,
        to = reverse and -popup.height or popup.y,
        set_pos = function(pos) popup.y = pos end
    }
end

local function animate(popup, path, on_start, on_end)
    popup.y = path.from

    local animation = rubato.timed {
        pos = path.from,

        duration = 0.3,
        easing = rubato.easing.quadratic,
        awestore_compat = true,

        subscribed = path.set_pos,
    }

    animation.started:subscribe(on_start)
    animation.ended:subscribe(on_end)

    animation.target = path.to

end

function module.toggle(popup, path_func, on_end)
    if popup.animation_lock then return end
    popup.animation_lock = true

    local lazy_popup = wibox {
        ontop = popup.ontop,
        x = popup.x,
        y = popup.y,
        width = popup.width,
        height = popup.height,
        border_width = popup.border_width,
        border_color = popup.border_color,

        widget = {
            image = draw_to_image_surface(
                popup.widget,
                popup.width,
                popup.height,
                nil,
                nil,
                popup._drawable.background_color,
                popup._drawable.foreground_color
            ),
            resize = false,
            widget = wibox.widget.imagebox
        }
    }

    local path = path_func(lazy_popup, popup.visible)

    if popup.visible then
        animate(lazy_popup, path,
            function()
                lazy_popup.visible = true
                popup.visible = false
            end,

            function()
                lazy_popup.visible = false

                popup.animation_lock = false
                if on_end then on_end(false) end
            end
        )
    else
        animate(lazy_popup, path,
            function()
                lazy_popup.visible = true
            end,

            function()
                popup.visible = true
                lazy_popup.visible = false

                popup.animation_lock = false
                if on_end then on_end(true) end
            end
        )
    end
end

return module
