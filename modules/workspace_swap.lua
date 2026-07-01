local M = {}

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

    hl.dispatch(hl.dsp.workspace.swap_monitors({ monitor1 = "current", monitor2 = "+1", }))

    hl.dispatch(hl.dsp.workspace.change_id({ workspace = other_ws, id = tmp, }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = current_ws, id = other_ws, }))
    hl.dispatch(hl.dsp.workspace.change_id({ workspace = tmp, id = current_ws, }))

end

hl.on("workspace.move_to_monitor", function()
    hl.exec_cmd("hyprctl reload")
end)

return M
