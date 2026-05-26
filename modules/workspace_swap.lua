local M = {}

local function swap_workspace_ids(id1, id2)
    local tmp = 999999

    hl.dispatch(hl.dsp.workspace.change_id({
        workspace = id2,
        id = tmp,
    }))

    hl.dispatch(hl.dsp.workspace.change_id({
        workspace = id1,
        id = id2,
    }))

    hl.dispatch(hl.dsp.workspace.change_id({
        workspace = tmp,
        id = id1,
    }))
end

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
    local other_ws = other.active_workspace.id

    hl.dispatch(hl.dsp.workspace.swap_monitors({
        monitor1 = "current",
        monitor2 = "+1",
    }))

    -- Wait for Hyprland to finish moving the workspaces.
hl.timer(function()
        swap_workspace_ids(current_ws, other_ws)
    end, { timeout = 50, type = "oneshot"})
end

return M
