local env = require("modules.env")
local rules = require("modules.rules")
local focus = require("modules.cycle")
local ws_swap = require("modules.workspace_swap")

local mainMod = "SUPER"

-- toggle screen share on/off for noscreenshare-general window rule
hl.bind(mainMod .. " + SHIFT + O", function()
	if rules.screen_share_rule:is_enabled() then
		rules.screen_share_rule:set_enabled(false)
	else
		rules.screen_share_rule:set_enabled(true)
	end
end, { description = "Toggle screen share" })

local exec_cmd = {
	{
		key = "SHIFT + T",
		cmd = env.envExec .. "kitty -1 --class=kittyterminal -T Projects -e sesh connect Projects",
		desc = "Open Terminal with TMUX session:Projects",
	},
	{
		key = "SHIFT + Return",
		cmd = env.envExec .. "kitty -1 -e sesh connect stuff",
		desc = "Open Terminal with TMUX session:stuff",
	},
	{
		key = "Escape",
		cmd = "dms ipc powermenu open",
		desc = "Open Powermenu",
	},
	{
		key = "SHIFT + W",
		cmd = "zen-browser -new-window",
		desc = "Open another zen window",
	},
	{
		key = "SHIFT + S",
		cmd = env.envExec .. "kitty -1 -T PowerShell -e sesh connect PowerShell",
		desc = "Open Terminal with TMUX session:PowerShell",
	},

	-- rofi / vicinae
	{
		key = "0",
		cmd = "ROFI_PASS_CONFIG='" .. env.confDir .. "/rofi-pass/config' rofi-pass",
		desc = "Open rofi-pass",
	},
	{
		key = "Grave",
		cmd = "vicinae vicinae://launch/wm/switch-windows",
		desc = "Vicinae Switch windows",
	},
	{
		key = "Y",
		cmd = "vicinae vicinae://launch/clipboard/history",
		desc = "Vicinae Clipboard History",
	},
	{
		key = "SHIFT + P",
		cmd = "powerprofiles.sh",
		desc = "Rofi Powerprofiles",
	},
	{
		key = "SHIFT + C",
		cmd = "pkill bemenu || bemenu_input 6",
		desc = "Bemenu Input",
		release = true,
	},
	{ key = "N", cmd = "nvim-hypr-anywhere.sh", desc = "Open nvim-hypr-anywhere" },
	{ key = "SHIFT + N", cmd = env.envExec .. "kitty -1 -T btop -e nvtop", desc = "Open nvtop" },
	{ key = "X", cmd = "dms ipc call bar toggle index 0", desc = "Toggle dank bar" },
	{ key = "CTRL + P", cmd = "dms ipc wallpaperCarousel toggle", desc = "Toggle wallpaperCarousel" },
	{ key = "CTRL + T", cmd = "dms ipc typingSounds toggle", desc = "Toggle typingSounds" },

	-- screenshots
	-- key with a space at the beginning is a bind without using the mainMod.
	{ key = " Print", cmd = "quickshell -c HyprQuickFrame -n", desc = "OCR / Google Lens" },
	{ key = "Print", cmd = "quickshell -c QuickSnip -n", desc = "Screenshot" },

	-- kitty scratch terminal
	{
		key = "CTRL + Grave",
		cmd = "kitten quick-access-terminal",
		desc = "Open Kitty Quick Access Terminal",
		locked = true,
	},
}

for _, b in ipairs(exec_cmd) do
	local opts = {
		description = b.desc,
	}

	if b.release then
		opts.release = true
	end
	if b.locked then
		opts.locked = true
	end

	local nomod = string.sub(b.key, 1, 1)
	if nomod == " " then
		hl.bind(b.key, hl.dsp.exec_cmd(b.cmd), opts)
	else
		hl.bind(mainMod .. " + " .. b.key, hl.dsp.exec_cmd(b.cmd), opts)
	end
end

local dispatch_window = {
	{
		key = "F",
		action = hl.dsp.window.fullscreen({ mode = "fullscreen" }),
		desc = "Fullscreen focused app",
	},
	{
		key = "Q",
		action = hl.dsp.window.close({ window = "activewindow" }),
		desc = "Close focused app",
	},
	{
		key = "SHIFT + Q",
		action = hl.dsp.window.kill({ window = "activewindow" }),
		desc = "Kill focused app",
	},
	{
		key = "SHIFT + F",
		action = hl.dsp.window.fullscreen_state({ internal = 1, client = 2, action = "toggle" }),
		desc = "Maximize fake fullscreen app",
	},
	{
		key = "V",
		action = hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
		desc = "Float focused app",
	},
	{
		key = "CTRL + G",
		action = hl.dsp.window.move({ out_of_group = "r" }),
		desc = "Move app out of group",
	},

	-- mark, unmark and focus marked window
	{
		key = "SHIFT + Apostrophe",
		action = hl.dsp.window.tag({ tag = "+mark1" }),
		desc = "Tag mark1 focused window",
	},
	{
		key = "CTRL + Apostrophe",
		action = hl.dsp.window.tag({ tag = "-mark1" }),
		desc = "Untag mark1 focused window",
	},
	{
		key = "Apostrophe",
		action = hl.dsp.focus({ window = "tag:mark1" }),
		desc = "Focus tag:mark1 window",
	},
	{
		key = "SHIFT + Semicolon",
		action = hl.dsp.window.tag({ tag = "+mark2" }),
		desc = "Tag mark2 focused window",
	},
	{
		key = "CTRL + Semicolon",
		action = hl.dsp.window.tag({ tag = "-mark2" }),
		desc = "Untag mark2 focused window",
	},
	{
		key = "Semicolon",
		action = hl.dsp.focus({ window = "tag:mark2" }),
		desc = "Focus tag:mark2 window",
	},
	{
		key = "SHIFT + Comma",
		action = hl.dsp.window.move({ monitor = "-1" }),
		desc = "Move focused window to monitor on the left",
	},
	{
		key = "SHIFT + Period",
		action = hl.dsp.window.move({ monitor = "+1" }),
		desc = "Move focused window to monitor on the right",
	},
}

for _, b in ipairs(dispatch_window) do
	hl.bind(mainMod .. " + " .. b.key, b.action, { description = b.desc, universal_submap = true })
end

-- Group binds
hl.bind(mainMod .. " + G", function()
	local group = hl.get_active_window().group
	if not group or #group.members == 1 then
		hl.dispatch(hl.dsp.group.toggle())
		return
	end
	hl.dispatch(hl.dsp.group.lock_active())
end, { description = "Toggle group / Lock group" })

-- Game Mode
hl.bind(mainMod .. " + SHIFT + B", function()
	if not hl.get_config("animations.enabled") then
		hl.exec_cmd("hyprctl reload")
		return
	end
	hl.config({
		animations = { enabled = false },
		decoration = { shadow = { enabled = false }, rounding = 0, blur = { enabled = false } },
		general = { gaps_in = 0, gaps_out = 0, border_size = 0 },
	})
end, { description = "Toggle Game Mode" })

-- Toggle mic in Teams / Google Meet based on the focused window
-- Teams (teams-for-linux): Ctrl+Shift+M  |  Google Meet (browser): Ctrl+D
hl.bind(mainMod .. " + CTRL + M", function()
	local active = hl.get_active_window()
	if not active then
		return
	end

	local class = active.class or ""
	local title = active.title or ""

	local shortcut
	local mods

	if class:match("teams%-for%-linux") then
		shortcut, mods = "M", "CTRL SHIFT"
	elseif title:match("Meet") then
		shortcut, mods = "D", "CTRL"
	else
		return
	end

	hl.dispatch(hl.dsp.send_shortcut({ mods = mods, key = shortcut }))
end, { description = "Toggle mic (Teams: Ctrl+Shift+M, Meet: Ctrl+D)" })

-- Special Keys
local media_binds = {
	{
		key = "XF86AudioRaiseVolume",
		cmd = "dms ipc call audio increment 5",
		desc = "Raise volume",
	},
	{
		key = "XF86AudioLowerVolume",
		cmd = "dms ipc call audio decrement 5",
		desc = "Lower volume",
	},
	{
		key = "XF86AudioMute",
		cmd = "dms ipc call audio mute",
		desc = "Mute audio",
	},
	{
		key = "XF86AudioMicMute",
		cmd = "dms ipc call audio micmute",
		desc = "Mute Microphone",
	},
	{
		key = "xf86audioplay",
		cmd = "playerctl play-pause",
		desc = "Play/Pause",
	},
	{
		key = "xf86audionext",
		cmd = "playerctl next",
		desc = "Play Next Track",
	},
	{
		key = "xf86audioprev",
		cmd = "playerctl previous",
		desc = "Play Previous Track",
	},
}

for _, b in ipairs(media_binds) do
	hl.bind(b.key, hl.dsp.exec_cmd(b.cmd), {
		description = b.desc,
		locked = true,
		repeating = true,
		universal_submap = true,
	})
end

-- Special workspace
local special_workspaces = {
	terminal = { key = "U" },
	steam = { key = "Backspace" },
	trash = { key = "Delete" },
	whatsapp = { key = "O" },
	pulsesecure = { key = "6" },
	forticlient = { key = "7" },
	rmpc = { key = "I" },
}

for name, cfg in pairs(special_workspaces) do
	local key = cfg.key

	-- toggle special workspace
	hl.bind(mainMod .. " + " .. key, hl.dsp.workspace.toggle_special(name), {
		description = "Toggle " .. name .. " workspace",
		submap_universal = true,
	})

	-- move to special workspace
	hl.bind(
		mainMod .. " + SHIFT + " .. key,
		hl.dsp.workspace.move({
			workspace = "special:" .. name,
			monitor = "current",
		}),
		{
			description = "Move to " .. name .. " workspace",
			submap_universal = true,
		}
	)
end

-- mouse:272 = left
-- mouse:273 = right
-- mouse:274 = middle
-- mouse:275 = side
-- mouse:276 = extra
-- Move/resize windows with SUPER + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "scroll_move" })

hl.bind(
	mainMod .. " + mouse:274",
	hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
	{ mouse = true }
)

local throttled = false

local function throttled_dsp(dsp)
	return function()
		if throttled then
			return
		end
		throttled = true
		hl.dispatch(dsp)
		hl.timer(function()
			throttled = false
		end, {
			timeout = 200,
			type = "oneshot",
		})
	end
end

-- Zoom
hl.bind(
	mainMod .. " + mouse_up",
	throttled_dsp(function()
		local zoomFactor = hl.get_config("cursor.zoom_factor")
		if zoomFactor >= 10 then
			return 10
		end
		hl.config({
			cursor = { zoom_factor = zoomFactor + 0.5 },
		})
	end),
	{ description = "Zoom in" }
)

hl.bind(
	mainMod .. " + mouse_down",
	throttled_dsp(function()
		local zoomFactor = hl.get_config("cursor.zoom_factor")
		if zoomFactor <= 1 then
			return 1
		end
		hl.config({
			cursor = { zoom_factor = zoomFactor - 0.5 },
		})
	end),
	{ description = "Zoom out" }
)

hl.bind(mainMod .. " + SHIFT + mouse_up", function()
	hl.config({ cursor = { zoom_factor = 5 } })
end, { description = "Reset zoom factor" })

hl.bind(mainMod .. " + SHIFT + mouse_down", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end, { description = "Reset zoom factor" })

hl.bind(
	mainMod .. " + CTRL + mouse_up",
	throttled_dsp(hl.dsp.layout("move -col")),
	{ description = "Scroll windows right" }
)
hl.bind(
	mainMod .. " + CTRL + mouse_down",
	throttled_dsp(hl.dsp.layout("move +col")),
	{ description = "Scroll windows left" }
)

-- Allows dragging Picture-in-Picture windows with middle mouse drag and without holding SUPER
hl.bind("mouse:274", function()
	local active = hl.get_active_window()
	if active ~= nil and active.title == "Picture-in-Picture" then
		hl.dispatch(hl.dsp.window.drag())
	end
end, {
	mouse = true,
	non_consuming = true,
})

-- swap workspaces across monitors
hl.bind(mainMod .. " + SHIFT + CTRL + comma", function()
	ws_swap.swap()
end, { description = "Swap workspaces between monitors", submap_universal = true })
hl.bind(mainMod .. " + SHIFT + CTRL + period", function()
	ws_swap.swap()
end, { description = "Swap workspaces between monitors", submap_universal = true })

-- focus monitor.
hl.bind(
	mainMod .. " + comma",
	hl.dsp.focus({ monitor = "l" }),
	{ description = "Focus left monitor", submap_universal = true }
)
hl.bind(
	mainMod .. " + period",
	hl.dsp.focus({ monitor = "r" }),
	{ description = "Focus right monitor", submap_universal = true }
)

-- laptop lid switch
hl.bind("switch:on:[Lid Switch]", function()
	hl.monitor({ output = "eDP-1", disabled = false, locked = true })
end)
hl.bind("switch:off:[Lid Switch]", function()
	hl.monitor({ output = "eDP-1", disabled = true, locked = true })
end)

-- MRU cycle focus by class/title
local cycle_binds = {
	{ key = "W", match = "class", class = "zen", exec = env.envExec .. "zen-browser" },
	{ key = "T", match = "class", class = "kittyterminal", exec = env.envExec .. "kitty -1 --class=kittyterminal -e sesh connect stuff" },
	{
		key = "R",
		match = "class",
		class = "teams-for-linux",
		exec = "teams-for-linux-electron --ozone-platform-hint=auto",
	},
	{ key = "A", match = "class", class = "Prospect Mail", exec = "prospect-mail" },
	{ key = "Z", match = "class", class = "Apache Directory Studio", exec = "/opt/ApacheDirectoryStudio/ApacheDirectoryStudio" },
	{
		key = "SHIFT + A",
		match = "class",
		class = "brave-browser",
		exec = "brave -enable-features=UseOzonePlatform -ozone-platform=wayland",
	},
	{ key = "8", match = "class", class = "toipe", exec = env.envExec .. "kitty --class=toipe -o font_size=17 -e toofan" },
	{ key = "CTRL + W", match = "class", class = "microsoft-edge", exec = "microsoft-edge-stable" },
	{ key = "E", match = "class", class = "explorer", exec = env.envExec .. "kitty -1 --class=explorer -T explorer -e yazi" },
	{
		key = "S",
		match = "title",
		title = "PowerShell",
		exec = env.envExec .. "kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell",
	},
	{ key = "B", match = "title", title = "btop", exec = env.envExec .. "kitty -1 -T btop -e btop" },
}

for _, b in ipairs(cycle_binds) do
	hl.bind(mainMod .. " + " .. b.key, function()
		focus.cycle(b)
	end, {
		description = "Cycle focus by " .. b.match .. ": " .. (b.class or b.title),
	})
end

hl.bind(mainMod .. " + Tab", function()
	local c = {}
	c.class = hl.get_active_window().class
	c.exec = ""
	focus.cycle(c)
end, {
	description = "Cycle focus by current window's class",
	repeating = true,
})

-- DMS binds for Nvidia laptop
if env.hostname == "opalMMU" then
	hl.bind(
		"xf86calculator",
		hl.dsp.exec_cmd("vicinae vicinae://launch/calculator/history"),
		{ description = "Vicinae Calculator" }
	)

	-- DMS brightness binds
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd(
			"dms ipc call brightness increment 5 backlight:amdgpu_bl1; dms ipc call brightness increment 5 ddc-i2c-4"
		),
		{ description = "Increase brightness" }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd(
			"dms ipc call brightness decrement 5 backlight:amdgpu_bl1; dms ipc call brightness decrement 5 ddc-i2c-4"
		),
		{ description = "Decrease brightness" }
	)
	hl.bind(
		"SHIFT + XF86MonBrightnessDown",
		hl.dsp.exec_cmd(
			"dms ipc call brightness toggleExponential backlight:amdgpu_bl1; dms ipc call brightness toggleExponential ddc:i2c-4"
		),
		{ description = "Toggle exponential brightness" }
	)
else
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd("dms ipc call brightness increment 5 backlight:intel_backlight"),
		{ description = "Brightness Up" }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd("dms ipc call brightness decrement 5 backlight:intel_backlight"),
		{ description = "Brightness Down" }
	)
	hl.bind(
		"SHIFT + XF86MonBrightnessDown",
		hl.dsp.exec_cmd("dms ipc call brightness toggleExponential backlight:intel_backlight"),
		{ description = "Toggle Exponential Brightness" }
	)
end
