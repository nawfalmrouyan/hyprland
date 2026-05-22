local mainMod = "SUPER"
local WORKSPACES_PER_MONITOR = 3

-- Track monitors in connection order with their workspace base offsets
local monitors = {}

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

local function position_left_of_all(name)
	local all = hl.get_monitors()
	local m = nil
	for _, mon in ipairs(all) do
		if mon.name == name then
			m = mon
			break
		end
	end
	if not m then return end

	local leftmost_x = 0
	for _, mon in ipairs(all) do
		if mon.name ~= name then
			if mon.x < leftmost_x then
				leftmost_x = mon.x
			end
		end
	end
	local new_w = math.floor((m.width or 1920) / (m.scale or 1))
	local x = leftmost_x - new_w
	hl.monitor({
		output = name,
		mode = "preferred",
		position = string.format("%dx%d", x, 0),
		scale = m.scale or 1,
	})
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
	-- Position eDP-1 at 0, then everything else to its left
	for _, m in ipairs(existing) do
		if m.name == "eDP-1" then
			hl.monitor({
				output = m.name,
				mode = "preferred",
				position = "0x0",
				scale = m.scale or 1,
			})
			break
		end
	end
	for _, m in ipairs(existing) do
		if m.name ~= "eDP-1" then
			position_left_of_all(m.name)
		end
	end
end

-- Handle hotplug
hl.on("monitor.added", function(m)
	position_left_of_all(m.name)
	add_monitor(m.name)
end)

hl.on("monitor.removed", function(m)
	remove_monitor(m.name)
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
