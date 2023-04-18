local rubato = require "module.rubato"

local function intro(popup)
    if popup.animation_lock then return end
    popup.animation_lock = true

    popup.visible = true

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
    end)

    animation.target = target_y
end

local function outro(popup)
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
    end)

    animation.target = -popup.height

end

local function toggle(popup)
    if not popup.visible then
        intro(popup)
    else
        outro(popup)
    end
end

return {
    intro = intro,
    outro = outro,
    toggle = toggle
}
