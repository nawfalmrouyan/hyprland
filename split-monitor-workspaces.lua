local mainMod = "SUPER"
local WORKSPACES_PER_MONITOR = 3

-- Track monitors in connection order with their workspace base offsets
local monitors = {}
local saved_windows = {}

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
		hl.workspace_rule({ workspace = tostring(base + i), monitor = name })
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

local function relayout_monitors()
	local all = hl.get_monitors()
	if #all == 0 then return end

	-- Sort: non-eDP-1 first (by x), eDP-1 last, so eDP-1 is rightmost
	table.sort(all, function(a, b)
		if a.name == "eDP-1" then return false end
		if b.name == "eDP-1" then return true end
		return a.x < b.x
	end)

	local x = 0
	for _, m in ipairs(all) do
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

-- Catch monitors already connected at startup
-- Ensure eDP-1 is always first so it gets workspace base 0
local existing = hl.get_monitors()
if existing then
	table.sort(existing, function(a, b)
		if a.name == "eDP-1" then return true end
		if b.name == "eDP-1" then return false end
		return false
	end)
	for _, m in ipairs(existing) do
		add_monitor(m.name)
	end
	relayout_monitors()
end

-- Handle hotplug
hl.on("monitor.added", function(m)
	relayout_monitors()
	add_monitor(m.name)

	-- Restore windows saved from a previous removal of this monitor
	local saved = saved_windows[m.name]
	if saved then
		for ws_id, addrs in pairs(saved) do
			for _, addr in ipairs(addrs) do
				if hl.get_window("address:" .. addr) then
					hl.dispatch(hl.dsp.window.move({ workspace = ws_id, window = "address:" .. addr }))
				end
			end
		end
		saved_windows[m.name] = nil
	end
end)

hl.on("monitor.removed", function(m)
	-- Move all windows from the removed monitor's workspaces onto eDP-1
	local mon_entry = nil
	for _, entry in ipairs(monitors) do
		if entry.name == m.name then
			mon_entry = entry
			break
		end
	end

	if mon_entry and mon_entry.name ~= "eDP-1" then
		local target_base = 0
		for _, entry in ipairs(monitors) do
			if entry.name == "eDP-1" then
				target_base = entry.base
				break
			end
		end

		-- Save windows by workspace ID before moving
		saved_windows[m.name] = {}
		for i = 1, WORKSPACES_PER_MONITOR do
			local ws_id = mon_entry.base + i
			local windows = hl.get_workspace_windows(ws_id)
			if windows and #windows > 0 then
				saved_windows[m.name][ws_id] = {}
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
end
