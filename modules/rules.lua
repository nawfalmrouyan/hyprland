require("mocha")

local env = require("modules.env")

local M = {}

-- Commands are built once at startup, then looked up by special workspace name
-- instead of walking an if/elseif chain on every workspace.created event.
local special_workspace_cmds = {
	["special:terminal"] = "kitty --class=scratch -T scratch -e sesh connect WORK",
	-- --ozone-platform-hint=auto --enable-features=WebRTCPipeWireCapturer
	["special:whatsapp"] = env.home .. "/.config/WhatsAppWeb-linux-x64/WhatsAppWeb",
	["special:steam"] = "steam",
	["special:update"] = env.envExec .. "kitty -1 --class=update -T update -e yay -Syu",
	["special:pulsemixer"] = env.envExec .. "kitty -1 --class=update -T update -e pulsemixer",
	["special:pulsesecure"] = "/opt/pulsesecure/bin/pulseUI",
	["special:forticlient"] = "/opt/forticlient/gui/FortiClient",
	["special:rmpc"] = env.envExec .. "kitty -1 -T ytm -e rmpc",
	["special:trash"] = env.home .. "/.local/bin/sung",
}

hl.on("workspace.created", function(ws)
	local cmd = ws.name and special_workspace_cmds[ws.name]
	if cmd then
		hl.exec_cmd(cmd)
	end
end)

hl.workspace_rule({ workspace = "w[tv1]", no_border = true, no_rounding = true, gaps_out = 0, gaps_in = 0 })

local layer_rules = {
	{
		match = { namespace = "rofi|logout_dialog|vicinae" },
		dim_around = true,
		blur = true,
		animation = "popin",
	},
	{
		match = { namespace = "vicinae|ghostty-quick-terminal|kitty-quick-access" },
		blur = true,
		above_lock = 2,
		no_screen_share = true,
	},
	{
		match = { namespace = "swaync.*|dms.*" },
		no_screen_share = true,
	},
	{
		match = { namespace = "dms.bar" },
		no_screen_share = false,
	},
	{
		match = { namespace = "hyprhalt" },
		blur = true,
		ignore_alpha = 0,
	},
}

for _, rule in ipairs(layer_rules) do
	hl.layer_rule(rule)
end

local window_rules = {
	{
		name = "sigle_window_focused_border",
		match = { focus = true, workspace = "w[t1]" },
		border_size = 0,
	},
	{
		name = "movetag_border",
		match = { tag = "movetag" },
		border_size = 3,
	},
	{
		name = "tearing_steamgames",
		match = { class = "steam_app_.*" },
		immediate = true,
	},

	{
		name = "term window width",
		match = { class = "^(explorer|kitty|kittyterminal|footclient)$" },
		scrolling_width = 0.5,
	},

	{
		name = "remmina half window width",
		match = { class = "org.remmina.Remmina", title = "Remmina Remote Desktop Client" },
		scrolling_width = 0.5,
	},

	{
		name = "pulse-secure-rules",
		match = { class = "pulseUI" },
		float = true,
		center = true,
		size = { 900, 750 },
		workspace = "special:pulsesecure",
	},

	{
		name = "forticlient-rules",
		match = { initial_class = "FortiClient" },
		float = true,
		center = true,
		size = { 900, 750 },
		workspace = "special:forticlient",
	},

	{
		name = "chatapp-rules",
		match = { initial_class = "com.rtosta.zapzap|whatsappweb-nativefier-d40211|org.telegram.desktop" },
		float = true,
		center = true,
		size = { 1600, 960 },
		workspace = "special:whatsapp silent",
	},

	{
		name = "youtube-music-rules",
		match = { class = "com.github.th_ch.youtube_music|spotube|(YouTube Music for Desktop|sung)" },
		float = true,
		center = true,
		size = { 1600, 960 },
		workspace = "special:trash silent",
	},

	{
		name = "onlyoffice-popups",
		match = { float = "true", class = "DesktopEditors" },
		center = true,
	},

	{
		name = "center-float-windows-class",
		match = { class = "toipe|jamesdsp|hyprland-share-picker|nm-connection-editor|pavucontrol|Gimp|org.quickshell" },
		float = true,
		center = true,
		size = { 1200, 750 },
	},

	{
		name = "persistent-size-windows",
		match = { class = "qt5ct|qt6ct|FortiClient|yad" },
		float = true,
		center = true,
	},

	{
		name = "center-float-windows-title",
		match = { title = "Settings|Hyprshot|Open|(Publish as PDF or XPS|^Settings - .*|^Warning:.*)" },
		float = true,
		center = true,
		size = { 900, 750 },
	},

	-- grouping rules
	{
		match = {
			class = "whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|com.rtosta.zapzap|FortiClient|pulseUI",
		},
		group = "set",
	},

	{
		group = "override barred",
		match = { class = "foot|zen|xdg-desktop-portal-gtk" },
	},

	-- misc rules
	{
		center = true,
		match = { title = "LibreOffice" },
	},

	{
		tile = true,
		match = { class = "ONLYOFFICE" },
	},

	{
		float = true,
		match = { title = ".*Network Manager.*" },
	},

	{
		border_color = mauve,
		match = { float = true },
	},

	{
		border_size = 0,
		rounding = 0,
		match = { fullscreen = true },
	},

	{
		border_size = 0,
		rounding = 0,
		match = { fullscreen_state_internal = 1, fullscreen_state_client = 2 },
	},

	{
		opacity = "0.8 0.8",
		match = { pin = true },
	},

	{
		name = "steam-window",
		match = { class = "steam" },
		float = true,
	},

	{
		float = true,
		match = { class = "^(steam_app_.*)$", initial_title = "^(..+)$" },
	},

	{
		name = "steam",
		match = { class = "steam", title = "Steam|(Sign in to Steam)" },
		workspace = "special:steam silent",
		float = true,
		center = true,
		size = { 1600, 960 },
	},

	{
		name = "idle-inhibit-apps",
		match = { class = "teams-for-linux" },
		idle_inhibit = "focus",
	},

	{
		name = "zen-pip-rules",
		match = { class = "zen", title = "Picture-in-Picture" },
		float = true,
		max_size = { 800, 800 },
	},

	{
		name = "noscreenshare-terminal",
		match = { title = "noscreenshare" },
		no_screen_share = true,
	},

	{
		name = "center-float-app",
		match = { class = "waypaper|qt6ct|qt5ct" },
		float = true,
		size = { 900, 750 },
		center = true,
	},

	{
		name = "picker-title-rules",
		match = {
			title = "([Ff]ile Upload)|(Enter name of file to save to.*)|(blob.*)|(Open [Ff]iles)|(Open folder.*)",
		},
		size = { 1345, 720 },
		float = true,
		center = true,
	},

	{
		float = true,
		size = { 1345, 720 },
		center = true,
		match = { class = "(soffice|Save Image|Save As|xdg-desktop-portal-gtk)" },
	},

	{
		name = "waybar-popups",
		match = { initial_class = "(blueman-manager)|(com.network.manager)" },
		animation = "slide",
		stay_focused = true,
		float = true,
		size = { 1280, 700 },
		move = { 380, 35 },
	},

	{
		name = "xwaylandvideobridge",
		match = { class = "xwaylandvideobridge" },
		opacity = "0.0 override 0.0 override",
		no_anim = true,
		no_focus = true,
		no_initial_focus = true,
		workspace = "special:junks silent",
	},

	{
		name = "tui-window",
		match = { class = "update", title = "update" },
		animation = "slide",
		float = true,
		size = { 1280, 700 },
		move = { 380, 43 },
		workspace = "special:update",
	},

	{
		name = "nvim-hypr-anywhere",
		match = { class = "nvim-hypr-anywhere" },
		animation = "slide",
		float = true,
		pin = true,
		size = { 1280, 700 },
		center = true,
	},

	{
		name = "stats-window",
		match = { initial_title = "btop" },
		animation = "popin",
		float = true,
		pin = true,
		size = { 1280, 700 },
		center = true,
	},

	{
		name = "ytm",
		match = { initial_title = "ytm" },
		animation = "popin",
		size = { 1280, 700 },
		float = true,
		center = true,
	},

	{
		name = "terminal-scratchpad",
		match = { class = "scratch", title = "scratch" },
		animation = "slide",
		float = true,
		size = { 1440, 700 },
		move = { 240, 377 },
	},

	{
		name = "no-focus-window",
		match = { title = "^(Peek preview)$" },
		no_focus = true,
		scrolling_width = 0.5,
	},

	{
		name = "sioyek-window",
		match = { class = "sioyek" },
		scrolling_width = 0.5,
	},

	{
		name = "suppressevent-maximize",
		match = { class = ".*" },
		suppress_event = "maximize",
	},

	{
		name = "fix-xwayland-drags",
		match = {
			class = "^$",
			title = "^$",
			xwayland = true,
			float = true,
			fullscreen = false,
			pin = false,
		},
		no_focus = true,
	},

	{
		name = "cable-uhid-bridge-center-float",
		match = {
			class = "^(cable-uhid-bridge)$",
		},
		float = true,
		center = true,
	},

	{
		name = "Sung-float-pin",
		match = {
			title = "^(Sung · Mini player)$",
		},
		float = true,
		pin = true,
	},
}

for _, rule in ipairs(window_rules) do
	hl.window_rule(rule)
end

M.screen_share_rule = hl.window_rule({
	name = "noscreenshare-general",
	match = {
		class = "whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|steam|com.rtosta.zapzap",
	},
	no_screen_share = true,
})

return M
