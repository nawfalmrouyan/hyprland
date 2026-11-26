local env = require("modules.env")
local uwsm = require("modules.uwsm")
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
end, { description = "Toggle screen share privacy filter (noscreenshare rule)" })

local exec_cmd = {
	{
		key = "SHIFT + T",
		cmd = uwsm.app(env.envExec .. "kitty -1 --class=kittyterminal -T Projects -e sesh connect Projects"),
		desc = "Open Terminal (tmux session: Projects)",
	},
	{
		key = "SHIFT + Return",
		cmd = uwsm.app(env.envExec .. "kitty -1 -e sesh connect stuff"),
		desc = "Open Terminal (tmux session: stuff)",
	},
	{
		key = "Escape",
		cmd = "dms ipc powermenu open",
		desc = "Open DMS power menu",
	},
	{
		key = "SHIFT + W",
		cmd = uwsm.app("zen-browser -new-window"),
		desc = "Open new Zen Browser window",
	},
	{
		key = "SHIFT + S",
		cmd = uwsm.app(env.envExec .. "kitty -1 -T PowerShell -e sesh connect PowerShell"),
		desc = "Open Terminal (tmux session: PowerShell)",
	},

	-- rofi / vicinae
	{
		key = "0",
		cmd = uwsm.app("env ROFI_PASS_CONFIG='" .. env.confDir .. "/rofi-pass/config' rofi-pass"),
		desc = "Open password manager (rofi-pass)",
	},
	{
		key = "Grave",
		cmd = "vicinae vicinae://launch/wm/switch-windows",
		desc = "Switch windows (Vicinae)",
	},
	{
		key = "Y",
		cmd = "vicinae vicinae://launch/clipboard/history",
		desc = "Open clipboard history (Vicinae)",
	},
	{
		key = "SHIFT + P",
		cmd = uwsm.app("powerprofiles.sh"),
		desc = "Select power profile (Rofi)",
	},
	{
		key = "SHIFT + C",
		cmd = uwsm.app("sh -c 'pkill bemenu || bemenu_input 6'"),
		desc = "Open quick input menu (bemenu)",
		release = true,
	},
	{ key = "N", cmd = uwsm.app("nvim-hypr-anywhere.sh"), desc = "Open quick text editor (nvim-hypr-anywhere)" },
	{ key = "SHIFT + N", cmd = uwsm.app(env.envExec .. "kitty -1 -T btop -e nvtop"), desc = "Open GPU task monitor (nvtop in Kitty)" },
	{ key = "X", cmd = "dms ipc call bar toggle index 0", desc = "Toggle DMS top bar" },
	{ key = "CTRL + P", cmd = "dms ipc wallhavenCarousel toggle", desc = "Toggle DMS wallpaper carousel" },
	{ key = "CTRL + T", cmd = "dms ipc typingSounds toggle", desc = "Toggle DMS typing sound effects" },

	-- screenshots
	-- key with a space at the beginning is a bind without using the mainMod.
	{ key = " Print", cmd = uwsm.app("quickshell -c HyprQuickFrame -n"), desc = "OCR / visual search screen area (HyprQuickFrame)" },
	{ key = "Print", cmd = uwsm.app("quickshell -c QuickSnip -n"), desc = "Take interactive screenshot (QuickSnip)" },

	-- kitty scratch terminal
	{
		key = "CTRL + Grave",
		cmd = "kitten quick-access-terminal",
		desc = "Toggle Kitty quick-access drop-down terminal",
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
		desc = "Toggle fullscreen mode",
	},
	{
		key = "Q",
		action = hl.dsp.window.close({ window = "activewindow" }),
		desc = "Close active window",
	},
	{
		key = "SHIFT + Q",
		action = hl.dsp.window.kill({ window = "activewindow" }),
		desc = "Force kill active window process",
	},
	{
		key = "SHIFT + F",
		action = hl.dsp.window.fullscreen_state({ internal = 1, client = 2, action = "toggle" }),
		desc = "Toggle fake fullscreen / maximize active window",
	},
	{
		key = "V",
		action = hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
		desc = "Toggle floating mode for active window",
	},
	{
		key = "CTRL + G",
		action = hl.dsp.window.move({ out_of_group = "r" }),
		desc = "Move active window out of group (right)",
	},

	-- mark, unmark and focus marked window
	{
		key = "SHIFT + Apostrophe",
		action = hl.dsp.window.tag({ tag = "+mark1" }),
		desc = "Tag active window as mark1",
	},
	{
		key = "CTRL + Apostrophe",
		action = hl.dsp.window.tag({ tag = "-mark1" }),
		desc = "Remove mark1 tag from active window",
	},
	{
		key = "Apostrophe",
		action = hl.dsp.focus({ window = "tag:mark1" }),
		desc = "Focus window tagged mark1",
	},
	{
		key = "SHIFT + Semicolon",
		action = hl.dsp.window.tag({ tag = "+mark2" }),
		desc = "Tag active window as mark2",
	},
	{
		key = "CTRL + Semicolon",
		action = hl.dsp.window.tag({ tag = "-mark2" }),
		desc = "Remove mark2 tag from active window",
	},
	{
		key = "Semicolon",
		action = hl.dsp.focus({ window = "tag:mark2" }),
		desc = "Focus window tagged mark2",
	},
	{
		key = "SHIFT + Comma",
		action = hl.dsp.window.move({ monitor = "-1" }),
		desc = "Move active window to left monitor",
	},
	{
		key = "SHIFT + Period",
		action = hl.dsp.window.move({ monitor = "+1" }),
		desc = "Move active window to right monitor",
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
end, { description = "Toggle window group or lock active group" })

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
end, { description = "Toggle Game Mode (disable animations, shadows, blur, and gaps)" })

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
end, { description = "Toggle microphone in active meeting (Teams / Google Meet)" })

-- Special Keys
local media_binds = {
	{
		key = "XF86AudioRaiseVolume",
		cmd = "dms ipc call audio increment 5",
		desc = "Increase audio volume by 5%",
	},
	{
		key = "XF86AudioLowerVolume",
		cmd = "dms ipc call audio decrement 5",
		desc = "Decrease audio volume by 5%",
	},
	{
		key = "XF86AudioMute",
		cmd = "dms ipc call audio mute",
		desc = "Toggle audio mute",
	},
	{
		key = "XF86AudioMicMute",
		cmd = "dms ipc call audio micmute",
		desc = "Toggle microphone mute",
	},
	{
		key = "xf86audioplay",
		cmd = "playerctl play-pause",
		desc = "Toggle media playback (play/pause)",
	},
	{
		key = "xf86audionext",
		cmd = "playerctl next",
		desc = "Skip to next media track",
	},
	{
		key = "xf86audioprev",
		cmd = "playerctl previous",
		desc = "Return to previous media track",
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
		description = "Toggle special workspace: " .. name,
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
			description = "Move active window to special workspace: " .. name,
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
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Move window by dragging" })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true, description = "Resize window by dragging" })

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = 1, mode = "live" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "scroll_move" })

hl.bind(
	mainMod .. " + mouse:274",
	hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
	{ mouse = true, description = "Toggle floating for active window via middle click" }
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
	{ description = "Zoom in desktop (increase zoom factor)" }
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
	{ description = "Zoom out desktop (decrease zoom factor)" }
)

hl.bind(mainMod .. " + SHIFT + mouse_up", function()
	hl.config({ cursor = { zoom_factor = 5 } })
end, { description = "Set zoom factor preset to 5x" })

hl.bind(mainMod .. " + SHIFT + mouse_down", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end, { description = "Reset zoom factor to 1x" })

hl.bind(
	mainMod .. " + CTRL + mouse_up",
	throttled_dsp(hl.dsp.layout("move -col")),
	{ description = "Scroll layout column left (move -col)" }
)
hl.bind(
	mainMod .. " + CTRL + mouse_down",
	throttled_dsp(hl.dsp.layout("move +col")),
	{ description = "Scroll layout column right (move +col)" }
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
	description = "Drag Picture-in-Picture window with middle mouse button",
})

-- swap workspaces across monitors
hl.bind(mainMod .. " + SHIFT + CTRL + comma", function()
	ws_swap.swap()
end, { description = "Swap active workspaces between monitors", submap_universal = true })
hl.bind(mainMod .. " + SHIFT + CTRL + period", function()
	ws_swap.swap()
end, { description = "Swap active workspaces between monitors", submap_universal = true })

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
end, { description = "Enable internal display (eDP-1) on lid open" })
hl.bind("switch:off:[Lid Switch]", function()
	hl.monitor({ output = "eDP-1", disabled = true, locked = true })
end, { description = "Disable internal display (eDP-1) on lid close" })

-- MRU cycle focus by class/title
local cycle_binds = {
	{ key = "W", match = "class", class = "zen", exec = env.envExec .. "zen-browser", desc = "Focus or launch Zen Browser" },
	{ key = "T", match = "class", class = "kittyterminal", exec = env.envExec .. "kitty -1 --class=kittyterminal -e sesh connect stuff", desc = "Focus or launch Terminal (tmux: stuff)" },
	{
		key = "R",
		match = "class",
		class = "teams-for-linux",
		exec = "teams-for-linux-electron --ozone-platform-hint=auto",
		desc = "Focus or launch Teams for Linux",
	},
	{ key = "A", match = "class", class = "Prospect Mail", exec = "prospect-mail -enable-features=UseOzonePlatform -ozone-platform=wayland", desc = "Focus or launch Prospect Mail (Outlook)" },
	{ key = "Z", match = "class", class = "Apache Directory Studio", exec = "/opt/ApacheDirectoryStudio/ApacheDirectoryStudio", desc = "Focus or launch Apache Directory Studio" },
	-- {
	-- 	key = "SHIFT + A",
	-- 	match = "class",
	-- 	class = "brave-browser",
	-- 	exec = "brave -enable-features=UseOzonePlatform -ozone-platform=wayland",
	-- 	desc = "Focus or launch Brave Browser",
	-- },
	{ key = "8", match = "class", class = "toipe", exec = env.envExec .. "kitty --class=toipe -o font_size=17 -e toofan", desc = "Focus or launch Toipe typing practice" },
	{ key = "CTRL + W", match = "class", class = "microsoft-edge", exec = "microsoft-edge-stable", desc = "Focus or launch Microsoft Edge" },
	{ key = "E", match = "class", class = "explorer", exec = env.envExec .. "kitty -1 --class=explorer -T explorer -e yazi", desc = "Focus or launch Yazi file manager" },
	{ key = "SHIFT + E", match = "class", class = "dfiles", exec = "dfiles", desc = "Focus or launch Dfiles file manager" },
	{
		key = "S",
		match = "title",
		title = "PowerShell",
		exec = env.envExec .. "kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell",
		desc = "Focus or launch PowerShell terminal",
	},
	{ key = "B", match = "title", title = "btop", exec = env.envExec .. "kitty -1 -T btop -e btop", desc = "Focus or launch btop system monitor" },
}

for _, b in ipairs(cycle_binds) do
	hl.bind(mainMod .. " + " .. b.key, function()
		focus.cycle(b)
	end, {
		description = b.desc or ("Cycle focus by " .. b.match .. ": " .. (b.class or b.title)),
	})
end

hl.bind(mainMod .. " + Tab", function()
	local c = {}
	c.class = hl.get_active_window().class
	c.exec = ""
	focus.cycle(c)
end, {
	description = "Cycle focus among windows of active application (same class)",
	repeating = true,
})

-- DMS binds for Nvidia laptop
if env.hostname == "opalMMU" then
	hl.bind(
		"xf86calculator",
		hl.dsp.exec_cmd("vicinae vicinae://launch/calculator/history"),
		{ description = "Open calculator history (Vicinae)" }
	)

	-- DMS brightness binds
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd(
			"dms ipc call brightness increment 5 backlight:amdgpu_bl1; dms ipc call brightness increment 5 ddc-i2c-4"
		),
		{ description = "Increase display brightness by 5% (internal + external)" }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd(
			"dms ipc call brightness decrement 5 backlight:amdgpu_bl1; dms ipc call brightness decrement 5 ddc-i2c-4"
		),
		{ description = "Decrease display brightness by 5% (internal + external)" }
	)
	hl.bind(
		"SHIFT + XF86MonBrightnessDown",
		hl.dsp.exec_cmd(
			"dms ipc call brightness toggleExponential backlight:amdgpu_bl1; dms ipc call brightness toggleExponential ddc:i2c-4"
		),
		{ description = "Toggle exponential brightness curve (internal + external)" }
	)
else
	hl.bind(
		"XF86MonBrightnessUp",
		hl.dsp.exec_cmd("dms ipc call brightness increment 5 backlight:intel_backlight"),
		{ description = "Increase display brightness by 5% (internal backlight)" }
	)
	hl.bind(
		"XF86MonBrightnessDown",
		hl.dsp.exec_cmd("dms ipc call brightness decrement 5 backlight:intel_backlight"),
		{ description = "Decrease display brightness by 5% (internal backlight)" }
	)
	hl.bind(
		"SHIFT + XF86MonBrightnessDown",
		hl.dsp.exec_cmd("dms ipc call brightness toggleExponential backlight:intel_backlight"),
		{ description = "Toggle exponential brightness curve (internal backlight)" }
	)
end
