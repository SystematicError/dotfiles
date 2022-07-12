local rubato = require "module.rubato"

DURATION = 0.3
START_OPACITY = 0.75

client.connect_signal("focus", function(c)
    if c and #c.screen.clients > 1 then
        rubato.timed({
            intro = 0,
            duration = DURATION,
            pos = START_OPACITY,

            easing = rubato.linear,

            subscribed = function(opacity)
                if c then
                    c.opacity = opacity
                end
            end
        }).target = 1
    end
end)

