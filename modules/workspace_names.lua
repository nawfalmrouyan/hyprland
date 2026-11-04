local M = {}

M.WORKSPACES_PER_MONITOR = 3
M.names = { "一", "二", "三" }

-- Workspace IDs are grouped in blocks of WORKSPACES_PER_MONITOR, one block per
-- monitor. Every block uses the same names so each monitor reads 一 二 三.
function M.name_for(id)
	id = tonumber(id)
	if not id or id <= 0 then
		return nil
	end

	local index = ((id - 1) % M.WORKSPACES_PER_MONITOR) + 1
	return M.names[index]
end

-- Rename an existing workspace to the name for its current slot. Used for
-- workspaces that existed before their default_name rule was added, and after
-- a workspace changes ID during a monitor swap.
function M.apply(id)
	local name = M.name_for(id)
	if not name then
		return
	end

	local ws = hl.get_workspace(id)
	if not ws or ws.special or ws.name == name then
		return
	end

	hl.dispatch(hl.dsp.workspace.rename({ workspace = id, name = name }))
end

return M
