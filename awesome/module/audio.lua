local awful = require "awful"

local module = {
    state = {
        sinks = {},
        sources = {},
        apps = {} -- AKA sink_inputs
    }
}

local function cmd(command, callback)
    awful.spawn.easy_async(command, function(output, _, _, exit_code)
        if exit_code == 0 then
            callback(output)
        else
            error("Internal audio command execution failed")
        end
    end)
end

local function update_state(args)
    local callback = args.callback
    local device_type = args.device_type
    local pattern = args.pattern

    cmd("pactl list " .. device_type, function(output)
        device_type = device_type == "sink-inputs" and "apps" or device_type

        module.state[device_type] = {}

        -- If no devices / playback streams available
        if #output:gsub("[%s%c]", "") == 0 then return callback() end

        while true do
            local index = output:find("\n\n")
            local info = output:sub(1, (index or 0) - 1)

            local id = info:match(pattern.id)
            local name = info:match(pattern.name)
            local description = info:match(pattern.description)

            local volume = tonumber(info:match("Volume: [^%c]+/%s+(%d+)%%%s+/[^%c]+"))
            local mute = (info:match("Mute: (%a%a%a?)") == "yes") and true or false
            local default = (not info:match("State: RUNNING\n")) and false or true

            table.insert(module.state[device_type], {
                id=id,
                name=name,
                description=description,
                volume=volume,
                mute=mute,
                default=default
            })

            if not index then break end
            output = output:sub(index + 2, -1)
        end

        callback()
    end)
end

function module.update_sink_state(callback)
    update_state {
        callback = callback,
        device_type = "sinks",

        pattern = {
            id = "Sink #(%d+)",
            name = "Name: ([^%c]+)",
            description = "Description: ([^%c]+)"
        }
    }
end

function module.update_source_state(callback)
    update_state {
        callback = callback,
        device_type = "sources",

        pattern = {
            id = "Source #(%d+)",
            name = "Name: ([^%c]+)",
            description = "Description: ([^%c]+)"
        }
    }
end

function module.update_app_state(callback)
    update_state {
        callback = callback,
        device_type = "sink-inputs",

        pattern = {
            id = "Sink Input #(%d+)",
            name = "application.name = \"([^%c]+)\"\n",
            description = "media.name = \"([^%c]+)\"\n"
        }
    }
end

-- Note that changing the volume or mute of a device does not update the state

local function set_mute(device_type, mute, id)
    if device_type == "sink-input" and not id then
        return error("Please supply ID when changing the state of a playback stream")
    end

    id = id or string.format("@DEFAULT_%s@", device_type:upper())
    awful.spawn(string.format("pactl set-%s-mute %s %s", device_type, id, mute), false)
end

function module.set_sink_mute(mute, id) set_mute("sink", mute, id) end
function module.set_source_mute(mute, id) set_mute("source", mute, id) end
function module.set_app_mute(mute, id) set_mute("sink-input", mute, id) end

local function set_volume(device_type, volume, id)
    if device_type == "sink-input" and not id then
        return error("Please supply ID when changing the state of a playback stream")
    end

    id = id or string.format("@DEFAULT_%s@", device_type:upper())
    awful.spawn(string.format("pactl set-%s-volume %s %s%%", device_type, id, volume), false)
end

function module.set_sink_volume(volume, id) set_volume("sink", volume, id) end
function module.set_source_volume(volume, id) set_volume("source", volume, id) end
function module.set_app_volume(volume, id) set_volume("sink-input", volume, id) end

-- Fancy functions, mainly intended for volume keybinds

STEP = 10 -- Increments to increase volume
THRESHOLD = 200 -- Maximum volume limit

local function toggle_mute(device_type)
    for _, device in ipairs(module.state[device_type .. "s"]) do
        if device.default then
            set_mute(device_type, not device.mute)
            awesome.emit_signal("volume_change", device_type, device.volume, not device.mute)
        end
    end
end

function module.toggle_sink_mute()
    module.update_sink_state(function() toggle_mute("sink") end)
end

function module.toggle_source_mute()
    module.update_source_state(function() toggle_mute("source") end)
end


local function increase_volume(device_type)
    for _, device in ipairs(module.state[device_type .. "s"]) do
        if device.default then
            local target_volume

            if device.volume >= THRESHOLD - STEP then
                target_volume = THRESHOLD
            else
                target_volume = device.volume + STEP
            end

            set_volume(device_type, target_volume)
            awesome.emit_signal("volume_change", device_type, target_volume, device.mute)
        end
    end
end

function module.increase_sink_volume()
    module.update_sink_state(function() increase_volume("sink") end)
end

function module.increase_source_volume()
    module.update_source_state(function() increase_volume("source") end)
end

local function decrease_volume(device_type)
    for _, device in ipairs(module.state[device_type .. "s"]) do
        if device.default then
            local target_volume

            if device.volume <= STEP then
                target_volume = 0
            else
                target_volume = device.volume - STEP
            end

            set_volume(device_type, target_volume)
            awesome.emit_signal("volume_change", device_type, target_volume, device.mute)
        end
    end
end

function module.decrease_sink_volume()
    module.update_sink_state(function() decrease_volume("sink") end)
end

function module.decrease_source_volume()
    module.update_source_state(function() decrease_volume("source") end)
end

return module

