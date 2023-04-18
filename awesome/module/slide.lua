local rubato = require "module.rubato"

local function intro(popup, on_done)
    popup.visible = true

    if popup.animation_lock then return end
    popup.animation_lock = true

    local target_y = popup.y

    local animation = rubato.timed {
        pos = -popup.height,

        duration = 0.2,
        easing = rubato.quadratic,
        awestore_compat = true,

        subscribed = function(pos) popup.y = pos end,
    }

    animation.ended:subscribe(function()
        popup.animation_lock = false
        if on_done then on_done() end
    end)

    animation.target = target_y
end

local function outro(popup, on_done)
    if popup.animation_lock then return end
    popup.animation_lock = true

    local init_y = popup.y

    local animation = rubato.timed {
        pos = init_y,

        duration = 0.2,
        easing = rubato.quadratic,
        awestore_compat = true,

        subscribed = function(pos) popup.y = pos end,
    }

    animation.ended:subscribe(function()
        popup.visible = false
        popup.y = init_y
        popup.animation_lock = false
        if on_done then on_done() end
    end)

    animation.target = -popup.height

end

local function toggle(popup, on_intro, on_outro)
    if not popup.visible then
        intro(popup, on_intro)
    else
        outro(popup, on_outro)
    end
end

return {
    intro = intro,
    outro = outro,
    toggle = toggle
}
