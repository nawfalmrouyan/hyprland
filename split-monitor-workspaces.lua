local mainMod = "SUPER"
local WORKSPACES_PER_MONITOR = 3
-- local WORKSPACE_NAMES = { "I", "II", "III" }
-- local WORKSPACE_NAMES = { "一", "二", "三" }

local PRIMARY_MONITOR = "eDP-1"

-- Track monitors in connection order with their workspace base offsets
local monitors = {}
local saved_windows = {}

-- Whether the second monitor should mirror PRIMARY_MONITOR. This stays true
-- even when the monitor is unplugged, so any second monitor that connects
-- afterwards is mirrored immediately.
local mirror_mode = false
-- Name of the monitor currently taking the mirror role
local mirror_target = nil

-- Tagged window border (Catppuccin Mocha red)
hl.window_rule({ match = { tag = "movetag" }, border_color = red .. " " .. red })

local function add_monitor(name)
	for _, m in ipairs(monitors) do
		if m.name == name then
			return
		end
	end

	local idx = #monitors + 1
	local base = (idx - 1) * WORKSPACES_PER_MONITOR
	table.insert(monitors, { name = name, base = base })

	for i = 1, WORKSPACES_PER_MONITOR do
		hl.workspace_rule({ workspace = tostring(base + i), monitor = name, })
		-- hl.workspace_rule({ workspace = tostring(base + i), monitor = name, default_name = WORKSPACE_NAMES[i] })
	end
end

local function remove_monitor(name)
	for i, m in ipairs(monitors) do
		if m.name == name then
			table.remove(monitors, i)
			return
		end
	end
end

local function get_base(name)
	for _, m in ipairs(monitors) do
		if m.name == name then
			return m.base
		end
	end
	return nil
end

-- Returns the monitor that should be treated as the second monitor. The
-- current mirror target wins, otherwise the first connected non-primary
-- monitor is used.
local function get_second_monitor()
	if mirror_target then
		local target = hl.get_monitor(mirror_target)
		if target then
			return target
		end
	end
	for _, m in ipairs(hl.get_monitors()) do
		if m.name ~= PRIMARY_MONITOR then
			return m
		end
	end
	return nil
end

local function is_mirrored(m)
	return m.is_mirror or (mirror_mode and mirror_target == m.name)
end

local function relayout_monitors()
	local all = hl.get_monitors()
	if #all == 0 then
		return
	end

	-- Sort: non-primary first (by x), primary last, so it is rightmost
	table.sort(all, function(a, b)
		if a.name == PRIMARY_MONITOR then
			return false
		end
		if b.name == PRIMARY_MONITOR then
			return true
		end
		return a.x < b.x
	end)

	local x = 0
	for _, m in ipairs(all) do
		-- A mirrored output cannot be positioned/own workspaces
		if not is_mirrored(m) then
			local w = math.floor((m.width or 1920) / (m.scale or 1))
			hl.monitor({
				output = m.name,
				mode = "preferred",
				position = string.format("%dx%d", x, 0),
				scale = m.scale or 1,
			})
			x = x + w
		end
	end
end

-- Save the monitor's windows by workspace, then move them onto the primary
-- monitor's matching workspaces.
local function save_and_move_to_primary(name)
	local from_base = get_base(name)
	local primary_base = get_base(PRIMARY_MONITOR)
	if not from_base or not primary_base then
		return
	end

	saved_windows[name] = saved_windows[name] or {}

	for i = 1, WORKSPACES_PER_MONITOR do
		local ws_id = from_base + i
		local windows = hl.get_workspace_windows(ws_id)
		if windows then
			saved_windows[name][ws_id] = saved_windows[name][ws_id] or {}
			for _, win in ipairs(windows) do
				table.insert(saved_windows[name][ws_id], win.address)
				hl.dispatch(hl.dsp.window.move({ workspace = primary_base + i, window = win }))
			end
		end
	end
end

local function restore_saved_windows(name)
	local saved = saved_windows[name]
	if not saved then
		return
	end

	for ws_id, addrs in pairs(saved) do
		for _, addr in ipairs(addrs) do
			if hl.get_window("address:" .. addr) then
				hl.dispatch(hl.dsp.window.move({ workspace = ws_id, window = "address:" .. addr }))
			end
		end
	end

	saved_windows[name] = nil
end

-- Base offset that a monitor would get if add_monitor() were called now
local function get_next_base(name)
	for _, m in ipairs(monitors) do
		if m.name == name then
			return m.base
		end
	end
	return #monitors * WORKSPACES_PER_MONITOR
end

-- Move saved windows from one monitor's role to another's, remapping the
-- workspace IDs to the new monitor's base offset.
local function transfer_saved_windows(from_name, to_name, to_base)
	local saved = saved_windows[from_name]
	if not saved then
		return
	end

	saved_windows[to_name] = saved_windows[to_name] or {}
	for ws_id, addrs in pairs(saved) do
		local from_base = math.floor((ws_id - 1) / WORKSPACES_PER_MONITOR) * WORKSPACES_PER_MONITOR
		local to_ws = to_base + (ws_id - from_base)

		saved_windows[to_name][to_ws] = saved_windows[to_name][to_ws] or {}
		for _, addr in ipairs(addrs) do
			table.insert(saved_windows[to_name][to_ws], addr)
		end
	end

	saved_windows[from_name] = nil
end

local function apply_mirror(target)
	local primary = hl.get_monitor(PRIMARY_MONITOR)
	hl.monitor({
		output = target,
		mode = "preferred",
		position = "0x0",
		scale = primary and primary.scale or 1,
		mirror = PRIMARY_MONITOR,
	})
end

local function disable_mirror(target)
	local mon = hl.get_monitor(target)
	hl.monitor({
		output = target,
		mode = "preferred",
		position = "0x0",
		scale = mon and mon.scale or 1,
		mirror = "",
	})
end

-- Catch monitors already connected at startup
-- Ensure the primary monitor is always first so it gets workspace base 0
local existing = hl.get_monitors()
if existing then
	table.sort(existing, function(a, b)
		if a.name == PRIMARY_MONITOR then
			return true
		end
		if b.name == PRIMARY_MONITOR then
			return false
		end
		return false
	end)
	for _, m in ipairs(existing) do
		add_monitor(m.name)
	end
	relayout_monitors()
end

-- Handle hotplug
hl.on("monitor.added", function(m)
	-- While mirroring, the next second monitor takes the mirror role
	if mirror_mode and m.name ~= PRIMARY_MONITOR then
		local current = mirror_target and hl.get_monitor(mirror_target)
		if not current or current.name == m.name then
			if mirror_target and mirror_target ~= m.name then
				transfer_saved_windows(mirror_target, m.name, get_next_base(m.name))
			end
			mirror_target = m.name
			relayout_monitors()
			apply_mirror(m.name)
			return
		end
	end

	relayout_monitors()
	add_monitor(m.name)

	-- Restore windows saved from a previous removal of this monitor
	restore_saved_windows(m.name)
end)

hl.on("monitor.removed", function(m)
	-- Mirrored monitors hold no windows, so there is nothing to save or move
	if mirror_mode and m.name ~= PRIMARY_MONITOR and (m.name == mirror_target or m.is_mirror) then
		remove_monitor(m.name)
		-- Keep mirror_target as the saved-window source so it can follow the
		-- next monitor that takes over the mirror role.
		relayout_monitors()
		return
	end

	-- Move all windows from the removed monitor's workspaces onto the primary
	local mon_entry = nil
	for _, entry in ipairs(monitors) do
		if entry.name == m.name then
			mon_entry = entry
			break
		end
	end

	if mon_entry and mon_entry.name ~= PRIMARY_MONITOR then
		local target_base = get_base(PRIMARY_MONITOR) or 0

		-- Save windows by workspace ID before moving
		saved_windows[m.name] = saved_windows[m.name] or {}
		for i = 1, WORKSPACES_PER_MONITOR do
			local ws_id = mon_entry.base + i
			local windows = hl.get_workspace_windows(ws_id)
			if windows and #windows > 0 then
				saved_windows[m.name][ws_id] = saved_windows[m.name][ws_id] or {}
				for _, win in ipairs(windows) do
					table.insert(saved_windows[m.name][ws_id], win.address)
				end
			end
		end

		for i = 1, WORKSPACES_PER_MONITOR do
			local ws_id = mon_entry.base + i
			local windows = hl.get_workspace_windows(ws_id)
			if windows then
				for _, win in ipairs(windows) do
					hl.dispatch(hl.dsp.window.move({ workspace = target_base + i, window = win }))
				end
			end
		end
	end

	remove_monitor(m.name)
	relayout_monitors()
end)

-- Fallback for unknown monitors
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

local function get_current_base()
	local m = hl.get_active_monitor()
	if not m then
		return 0
	end
	for _, mon in ipairs(monitors) do
		if mon.name == m.name then
			return mon.base
		end
	end
	return 0
end

local function switch_workspace(s)
	hl.dispatch(hl.dsp.focus({ workspace = get_current_base() + s }))
end

local function move_workspace(s, follow)
	hl.dispatch(hl.dsp.window.move({
		workspace = get_current_base() + s,
		follow = follow,
	}))
end

local function toggle_mirror()
	local second = get_second_monitor()

	-- No second monitor: remember the desired mode for when one connects
	if not second then
		mirror_mode = not mirror_mode
		mirror_target = nil
		hl.notification.create({
			text = mirror_mode
				and ("Second monitor will mirror " .. PRIMARY_MONITOR .. " when connected")
				or ("Second monitor will extend " .. PRIMARY_MONITOR .. " when connected"),
			timeout = 3000,
		})
		return
	end

	local target = second.name

	if mirror_mode then
		-- Back to using it as a second monitor
		mirror_mode = false
		mirror_target = nil
		disable_mirror(target)
		add_monitor(target)
		relayout_monitors()
		-- Wait for the monitor rule refresh before moving windows back, since a
		-- mirrored output cannot own workspaces yet.
		hl.timer(function()
			if not mirror_mode and hl.get_monitor(target) then
				restore_saved_windows(target)
			end
		end, {
			timeout = 200,
			type = "oneshot",
		})
	else
		-- Save the windows and move them onto the primary before mirroring
		save_and_move_to_primary(target)
		mirror_mode = true
		mirror_target = target
		apply_mirror(target)
		relayout_monitors()
	end
end

hl.bind(mainMod .. " + 9", toggle_mirror, {
	description = "Toggle second monitor mirror/extend",
	submap_universal = true,
})

-- Toggle tag on focused window
hl.bind(mainMod .. " + M", hl.dsp.window.tag({ tag = "movetag" }), {
	description = "Toggle movetag on focused window",
	submap_universal = true,
})

-- Generate keybinds based on WORKSPACES_PER_MONITOR
local workspace_keys = {}
for i = 1, WORKSPACES_PER_MONITOR do
	table.insert(workspace_keys, tostring(i))
end

for _, k in ipairs(workspace_keys) do
	local ws = tonumber(k)

	hl.bind(mainMod .. " + " .. k, function()
		switch_workspace(ws)
	end, { submap_universal = true })

	hl.bind(mainMod .. " + SHIFT + " .. k, function()
		move_workspace(ws)
	end, { submap_universal = true })

	hl.bind(mainMod .. " + CTRL + " .. k, function()
		move_workspace(ws, false)
	end, { submap_universal = true })

	hl.bind(mainMod .. " + ALT + " .. k, function()
		local tagged = hl.get_windows({ tag = "movetag" })
		if not tagged then
			return
		end
		local target = get_current_base() + ws
		for _, win in ipairs(tagged) do
			hl.dispatch(hl.dsp.window.move({ workspace = target, window = win }))
		end
	end, { submap_universal = true })
end
