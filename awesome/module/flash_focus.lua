local rubato = require "module.rubato"

DURATION = 0.3
START_OPACITY = 0.75

client.connect_signal("focus", function(c)
    -- Only flashes if multiple clients are visible
    if c and #c.screen.clients > 1 then
        local flash_animation = rubato.timed {
            intro = 0,
            duration = DURATION,
            pos = START_OPACITY,

            easing = rubato.linear,

            subscribed = function(opacity)
                -- Prevents errors if window closes while flashing
                if c.valid then
                    c.opacity = opacity
                end
            end
        }

        flash_animation.target = 1
    end
end)

