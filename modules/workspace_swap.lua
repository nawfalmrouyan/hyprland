local workspace_names = require("modules.workspace_names")

local M = {}

-- True only while M.swap() is moving workspaces between monitors. Hyprland
-- also emits workspace.move_to_monitor when a monitor starts mirroring (it
-- moves that monitor's workspaces away), and reloading the config there drops
-- the freshly added mirror rule.
local swapping = false

function M.swap()
    local monitors = hl.get_monitors()

    if #monitors ~= 2 then
        hl.notification.create({ text = "Exactly two monitors are required.", timeout = 3000, icon = "error"})
        return
    end

    local current, other

    if monitors[1].focused then
        current = monitors[1]
        other = monitors[2]
    else
        current = monitors[2]
        other = monitors[1]
    end

    local current_ws = current.active_workspace.id
    local other_ws  = other.active_workspace.id
    local tmp = 9999

    swapping = true
    hl.dispatch(hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1", }))

    hl.dispatch(hl.dsp.workspace.change_id({ workspace = other_ws, id = tmp, }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = current_ws, id = other_ws, }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = tmp, id = current_ws, }))

    -- change_id resets a workspace's display name to its new ID, so restore the
    -- name for the ID each monitor now holds.
    workspace_names.apply(current_ws)
    workspace_names.apply(other_ws)

    hl.timer(function()
        swapping = false
    end, { timeout = 200, type = "oneshot" })
end

hl.on("workspace.move_to_monitor", function()
    if swapping then
        hl.exec_cmd("hyprctl reload")
    end
end)

return M
