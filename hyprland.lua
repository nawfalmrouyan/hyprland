function getHostname()
	local f = io.popen("/bin/hostnamectl hostname")
	local hostname = f:read("*a") or ""
	f:close()
	hostname = string.gsub(hostname, "\n$", "")
	return hostname
end

require("mocha")

local mainMod = "SUPER"
local confDir = "/home/opal/.config/hypr"

local envs = {
	{ "_JAVA_AWT_WM_NONREPARENTING",         "1" },
	{ "QT_QPA_PLATFORMTHEME",                "gtk3" },
	{ "QT_QPA_PLATFORMTHEME_QT6",            "gtk3" },
	{ "QT_QPA_PLATFORM",                     "wayland" },
	{ "QT_AUTO_SCREEN_SCALE_FACTOR",         "1" },
	{ "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
	{ "MOZ_ENABLE_WAYLAND",                  "1" },
	{ "GDK_BACKEND",                         "wayland,x11,*" },
	{
		"PATH",
		"/home/opal/.local/bin:/home/opal/.config/hypr/scripts:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin",
	},
	{
		"GAMEMODERUNEXEC",
		"env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only",
	},
	{ "ELECTRON_OZONE_PLATFORM_HINT", "auto" },
	{ "HYPRCURSOR_THEME",             "catppuccin-mocha-mauve-cursors" },
	{ "HYPRCURSOR_SIZE",              "24" },
	{ "XCURSOR_THEME",                "catppuccin-mocha-mauve-cursors" },
	{ "XCURSOR_SIZE",                 "24" },
	{ "HYPRLAND_NO_CRASHREPORTER",    "1" },
	{ "XDG_CURRENT_DESKTOP",          "Hyprland" },
	{ "XDG_SESSION_TYPE",             "wayland" },
	{ "XDG_SESSION_DESKTOP",          "Hyprland" },
	{ "TERMINAL",                     "footclient" },
	{ "GTK_USE_PORTAL",               "1" },
}

for _, env in ipairs(envs) do
	hl.env(env[1], env[2])
end

if getHostname() == "opalMMU" then
	hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "0x0", scale = 1 })
	hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "1920x0", scale = 1 })
else
	hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "0x0", scale = 1 })
end

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "name", disabled = true })
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1"})

local workspaces = {
	{ start = 1, finish = 3, monitor = "eDP-1" },
	{ start = 4, finish = 6, monitor = "HDMI-A-1" },
}

for _, group in ipairs(workspaces) do
	for ws = group.start, group.finish do
		hl.workspace_rule({
			workspace = ws,
			monitor = group.monitor,
		})
	end
end

local on_created_empty = {
	{
		workspace = "special:terminal",
		cmd = "footclient -a scratch -T scratch -e sesh connect WORK",
	},
	{
		workspace = "special:trash",
		cmd = "youtube-music-for-desktop",
	},
	{
		workspace = "special:whatsapp",
		cmd = "/home/opal/.config/WhatsAppWeb-linux-x64/WhatsAppWeb",
	},
	{
		workspace = "special:steam",
		cmd = "steam",
	},
	{
		workspace = "special:update",
		cmd = "footclient -a update -T update -e yay -Syu",
	},
	{
		workspace = "special:pulsemixer",
		cmd = "footclient -a update -T update -e pulsemixer",
	},
	{
		workspace = "special:pulsesecure",
		cmd = "/opt/pulsesecure/bin/pulseUI",
	},
	{
		workspace = "special:forticlient",
		cmd = "/opt/forticlient/gui/FortiClient",
	},
	{
		workspace = "special:rmpc",
		cmd = "footclient -T ytm -e rmpc",
	},
}

for _, rule in ipairs(on_created_empty) do
	hl.workspace_rule({
		workspace = rule.workspace,
		on_created_empty = rule.cmd,
	})
end

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		special_fallthrough = true,
		follow_mouse = 1,
		numlock_by_default = true,
		repeat_rate = 25,
		repeat_delay = 600,
		focus_on_close = 2,
		-- scroll_method = edge,
		accel_profile = "adaptive",

		touchpad = {
			natural_scroll = true,
			tap_to_click = true,
			drag_lock = 1,
			disable_while_typing = true,
			drag_3fg = 1,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		enable_swallow = true,
		swallow_regex = "foot|kitty|com.mitchellh.ghostty",
		swallow_exception_regex = "^(noswallow)$",
		focus_on_activate = true,
		allow_session_lock_restore = true,
		font_family = "Pragmasevka Aile SmBd Cn",
		on_focus_under_fullscreen = 1,
	},

	cursor = {
		hide_on_touch = true,
		hide_on_key_press = true,
		persistent_warps = true,
		warp_on_change_workspace = 1,
		warp_on_toggle_special = 1,
		default_monitor = "HDMI-A-1",
		no_hardware_cursors = 2,
		use_cpu_buffer = 2,
	},

	binds = {
		workspace_back_and_forth = false,
		allow_pin_fullscreen = true,
		movefocus_cycles_fullscreen = true,
		movefocus_cycles_groupfirst = true,
	},

	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
		enforce_permissions = false,
	},

	debug = {
		disable_logs = true,
		enable_stdout_logs = false,
	},

	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 3,
		resize_on_border = false,
		col = {
			active_border = { colors = { mauve, blue }, angle = 45 },
			-- Unfocused window border color (fully transparent)
			inactive_border = "rgba(00000000)",
		},
		gaps_workspaces = 5,
		float_gaps = 3,
		layout = "scrolling",
		allow_tearing = true,

		snap = {
			enabled = true,
			respect_gaps = true,
			border_overlap = false,
			window_gap = 10,
			monitor_gap = 10,
		},
	},

	group = {
		col = {
			border_active = { colors = { mauve, blue }, angle = 45 },
			-- Unfocused window border color (fully transparent)
			border_inactive = "rgba(00000000)",
			border_locked_inactive = "rgba(00000000)",
			border_locked_active = { colors = { mauve, blue }, angle = 45 },
		},

		groupbar = {
			font_family = "Pragmasevka Aile SmBd Cn",
			keep_upper_gap = false,
			indicator_height = 7,
			blur = true,
			font_size = 15,
			gradients = false,
			render_titles = false,
			col = {
				active = mauve,
				-- Unfocused window border color (fully transparent)
				inactive = "rgba(00000000)",
				locked_inactive = teal,
				locked_active = mauve,
			},
		},
	},

	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		-- inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,
		-- dim_inactive = true,
		-- dim_strength = 0.7,
		-- dim_special = 0.3,
		-- dim_around = 0.5,

		blur = {
			size = 1,
			passes = 5,
			vibrancy = 0.1696,
			new_optimizations = true,
			popups = true,
		},

		shadow = {
			enabled = false,
			range = 11,
			render_power = 2,
			color = mauve,
		},

		glow = {
			enabled = false,
			range = 11,
			render_power = 2,
			color = mauve,
		},
	},

	animations = {
		enabled = true,
		workspace_wraparound = true,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})

hl.config({
	master = {
		new_status = "slave",
		mfact = 0.5,
		special_scale_factor = 0.9,
		allow_small_split = true,
		new_on_active = "after",
	},
})

hl.curve("simple", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("smooth", { type = "bezier", points = { { 0.25, 0.1 }, { 0.35, 0.15 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } })
hl.curve("smoothIn", { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })
hl.curve("cubic", { type = "bezier", points = { { 0.54, 0.22 }, { 0.07, 0.74 } } })
hl.curve("overshotCircle", { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } })
hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0.0 }, { 0, 1.0 } } })
hl.curve("bounce", { type = "bezier", points = { { 1, 1.6 }, { 0.1, 0.85 } } })
hl.curve("decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("easeoutexpo", { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } })
hl.curve("easeoutquad", { type = "bezier", points = { { 0.45, 0 }, { 0.55, 1 } } })

-- Default spring
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- Layers styles: slide, popin, fade
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "bounce", style = "slide 90%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "bounce", style = "slide 90%" })

-- Zoom
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Windows styles:slid", enabled = true, speed = popin, gnomed
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "bounce", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "bounce", style = "popin 85%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3, bezier = "md3_standard", style = "slide 90%" })

-- Border
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "overshot" })

-- styles: once", enabled = true, speed = loop
hl.animation({ leaf = "borderangle", enabled = true, speed = 100, bezier = "linear", style = "loop" })

-- Workspaces styles: slide", enabled = true, speed = slidevert, fade, slidefade, slidefadevert
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "bounce", style = "slidevert 90%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "bounce", style = "slidevert 90%" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "bounce", style = "slidevert 90%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "bounce", style = "slidevert 90%" })

-- Fade hl.animations
hl.animation({ leaf = "fadeIn", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadePopupsIn", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadePopupsOut", enabled = true, speed = 3, bezier = "smooth" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 3, bezier = "smooth" })

local layer_rules = {
	{
		match = { namespace = "rofi|logout_dialog|vicinae" },
		dim_around = true,
		blur = true,
		animation = "popin",
	},
	{
		match = { namespace = "ghostty-quick-terminal|kitty-quick-access" },
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
		name = "term window width",
		match = { class = "^(kitty|footclient)$" },
		scrolling_width = 0.5,
	},

	{
		name = "remmina half window width",
		match = { class = "org.remmina.Remmina", title = "Remmina Remote Desktop Client" },
		scrolling_width = 0.5,
	},

	{
		name = "pulse-secure-rules",
		match = { class = "pulseUI", title = "(Pulse Secure)" },
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
		match = { class = "com.github.th_ch.youtube_music|spotube|(YouTube Music for Desktop)" },
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
		size = { 900, 750 },
	},

	{
		name = "persistent-size-windows",
		match = { class = "qt5ct|qt6ct|feh|FortiClient|yad" },
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
			class =
			"whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|com.rtosta.zapzap|FortiClient|pulseUI",
		},
		group = "set",
	},

	{
		group = "override barred",
		match = { class = "foot|kitty|zen|xdg-desktop-portal-gtk" },
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
		border_color = { colors = { mauve, blue }, angle = 45 },
		match = { float = true },
	},

	{
		border_size = 0,
		match = { fullscreen = true },
	},

	{
		border_size = 0,
		match = { fullscreen_state_internal = 0, fullscreen_state_client = 2 },
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
		name = "torchlight2",
		match = { class = "Torchlight2.bin.x86_64", title = "(Torchlight II v.25.5.4)" },
		fullscreen = true,
		content = "game",
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
		name = "noscreenshare-general",
		match = {
			class =
			"whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|steam|com.rtosta.zapzap",
		},
		no_screen_share = true,
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
	},

	{
		name = "enable-tearing",
		match = { title = "(Grim Dawn)" },
		immediate = true,
		content = "game",
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
}

for _, rule in ipairs(window_rules) do
	hl.window_rule(rule)
end

hl.bind(
	mainMod .. " + T",
	hl.dsp.exec_cmd(
		"hypr-cycle-focus-lua.sh class footclient stuff footclient footclient -T stuff -e sesh connect stuff"
	),
	{ description = "Open Terminal with TMUX session:stuff" }
)
hl.bind(
	mainMod .. " + SHIFT + T",
	hl.dsp.exec_cmd("hypr-cycle-focus-lua.sh title Projects footclient -T Projects -e sesh connect Projects"),
	{ description = "Open Terminal with TMUX session:Projects" }
)
hl.bind(
	mainMod .. " + S",
	hl.dsp.exec_cmd("hypr-cycle-focus-lua.sh title PowerShell footclient -T PowerShell -e sesh connect PowerShell"),
	{ description = "Open Terminal with TMUX session:PowerShell" }
)
hl.bind(
	mainMod .. " + Return",
	hl.dsp.exec_cmd("footclient -e sesh connect stuff"),
	{ description = "Open Terminal with TMUX session:stuff" }
)
hl.bind(
	mainMod .. " + SHIFT + Return",
	hl.dsp.exec_cmd("footclient -e sesh connect stuff"),
	{ description = "Open Terminal with TMUX session:stuff" }
)
hl.bind(mainMod .. " + Q", hl.dsp.window.close({ window = "activewindow" }), { description = "Close focused app" })
hl.bind(
	mainMod .. " + SHIFT + Q",
	hl.dsp.window.kill({ window = "activewindow" }),
	{ description = "Kill focused app" }
)
hl.bind(
	mainMod .. " + A",
	hl.dsp.exec_cmd("hypr-cycle-focus-lua.sh class outlook-for-linux /opt/outlook-for-linux/outlook-for-linux"),
	{ description = "Open Outlook for Linux" }
)
hl.bind(
	mainMod .. " + Z",
	hl.dsp.exec_cmd(
		"hypr-cycle-focus-lua.sh class 'Apache Directory Studio' /opt/ApacheDirectoryStudio/ApacheDirectoryStudio"
	),
	{ description = "Open Apache Directory Studio" }
)
hl.bind(
	mainMod .. " + R",
	hl.dsp.exec_cmd(
		"hypr-cycle-focus-lua.sh class teams-for-linux teams-for-linux teams-for-linux /opt/teams-for-linux/teams-for-linux --ozone-platform-hint=auto"
	),
	{ description = "Open Teams for Linux" }
)
hl.bind(
	mainMod .. " + SHIFT + A",
	hl.dsp.exec_cmd(
		"hypr-cycle-focus-lua.sh class brave-browser brave -enable-features=UseOzonePlatform -ozone-platform=wayland"
	),
	{ description = "Open Brave Browser" }
)
hl.bind(
	mainMod .. " + F",
	hl.dsp.window.fullscreen({ mode = "fullscreen" }),
	{ description = "Fullscreen focused app" }
)
hl.bind(
	mainMod .. " + SHIFT + F",
	hl.dsp.window.fullscreen_state({ internal = 1, client = 2, action = "set" }),
	{ description = "Maximize fake fullscreen app" }
)
hl.bind(
	mainMod .. " + CTRL + F",
	hl.dsp.window.fullscreen_state({ internal = 0, client = 0, action = "set" }, {
		description = "Unmaximize fake fullscreen app",
	})
)
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("nautilus"), { description = "Open Nautilus" })
hl.bind(mainMod .. " + CTRL + E", hl.dsp.exec_cmd("kitty -e yazi"), { description = "Open yazi" })
hl.bind(
	mainMod .. " + V",
	hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
	{ description = "Float focused app" }
)
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("dms ipc powermenu open"), { description = "Open Powermenu" })

-- rofi/vicinae/bemenu, etc
hl.bind(
	mainMod .. " + 0",
	hl.dsp.exec_cmd("ROFI_PASS_CONFIG='" .. confDir .. "/rofi-pass/config' rofi-pass"),
	{ description = "Open rofi-pass" }
)
-- hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("rofi-beats"), { description = "Open Rofi Radio Stream" })
hl.bind(
	"ALT + Tab",
	hl.dsp.exec_cmd("vicinae vicinae://launch/wm/switch-windows"),
	{ description = "Vicinae Switch windows" }
)
hl.bind(
	mainMod .. " + E",
	hl.dsp.exec_cmd("vicinae vicinae://launch/core/search-emojis"),
	{ description = "Vicinae Search Emojis" }
)
hl.bind(
	mainMod .. " + Semicolon",
	hl.dsp.exec_cmd("vicinae vicinae://launch/clipboard/history"),
	{ description = "Vicinae Clipboard History" }
)
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("powerprofiles.sh"), { description = "Rofi Powerprofiles" })
hl.bind(
	mainMod .. " + C",
	hl.dsp.exec_cmd("pkill bemenu || bemenu_input 6"),
	{ description = "Bemenu Input", release = true }
)

-- compose text using nvim
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("nvim-hypr-anywhere.sh"), { description = "Open nvim-hypr-anywhere" })

-- bind = mainMod .. " + B, exec, killall -SIGUSR1 waybar || waybar
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("footclient -T btop -e btop"), { description = "Open btop" })
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("footclient -T btop -e nvtop"), { description = "Open nvtop" })
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("gamemode.sh"), { description = "Toggle Game Mode" })
hl.bind(
	mainMod .. " + 8",
	hl.dsp.exec_cmd("foot -c /home/opal/.config/foot/foot-anywhere.ini -a toipe -e toofan"),
	{ description = "Open Toofan (typing test)" }
)

-- Night mode (blue filter)
-- hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("hyprctl keyword decoration:screen_shader " .. scriptsDir .. "/flux.glsl"))
-- hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("hyprctl keyword decoration:screen_shader '[[EMPTY]]'"))

-- wayscriber
-- hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("pkill -SIGUSR1 wayscriber"), { description = "Toggle wayscriber" })

-- Group binds
hl.bind(
	mainMod .. " + G",
	hl.dsp.exec_cmd(
		"if [ $(hyprctl activewindow | rg 'grouped:' | rg -v 'Window' | tr -dc ',' | wc -c) -gt '0' ]; then hyprctl dispatch 'hl.dsp.group.lock_active()'; else hyprctl dispatch 'hl.dsp.group.toggle()'; fi"
	),
	{ description = "Toggle group / Lock group" }
)
hl.bind(mainMod .. " + Tab", hl.dsp.group.next(), { description = "Cycle windows in a group" })
hl.bind(mainMod .. " + CTRL + G", hl.dsp.window.move({ out_of_group = "r" }), { description = "Move app out of group" })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("quickshell -c HyprQuickFrame -n"), { description = "OCR / Google Lens" })
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("quickshell -c QuickSnip -n"), { description = "Screenshot" })

hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("dms ipc call bar toggle index 0"), { description = "Toggle dank bar" })
hl.bind(
	"CTRL + Grave",
	hl.dsp.exec_cmd("kitten quick-access-terminal"),
	{ description = "Open Kitty Quick Access Terminal", locked = true }
)

-- Special Keys
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("dms ipc call audio increment 5"),
	{ description = "Raise volume", locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("dms ipc call audio decrement 5"),
	{ description = "Lower volume", locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("dms ipc call audio mute"),
	{ description = "Mute audio", locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("dms ipc call audio micmute"),
	{ description = "Mute Microphone", locked = true, repeating = true }
)

hl.bind(
	"xf86audioplay",
	hl.dsp.exec_cmd("playerctl play-pause"),
	{ description = "Play/Pause", locked = true, repeating = true }
)
hl.bind(
	"xf86audionext",
	hl.dsp.exec_cmd("playerctl next"),
	{ description = "Play Next Track", locked = true, repeating = true }
)
hl.bind(
	"xf86audioprev",
	hl.dsp.exec_cmd("playerctl previous"),
	{ description = "Play Previous Track", locked = true, repeating = true }
)

-- Bypass global keybinds to pass binds directly to application (eg: VMs)
hl.bind(mainMod .. " + CTRL + Grave", hl.dsp.submap("passthru"))
hl.define_submap("passthru", function()
	hl.bind(mainMod .. " + Escape", hl.dsp.submap("reset"))
end)

-- Special workspace
-- hl.bind(mainMod .. " + SHIFT + U", hl.dsp.workspace.move({ workspace = "special:terminal", monitor = "current" }), { description = "Move to terminal workspace", submap_universal = true })
hl.bind(
	mainMod .. " + U",
	hl.dsp.workspace.toggle_special("terminal"),
	{ description = "Toggle terminal workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + Backspace",
	hl.dsp.workspace.move({ workspace = "special:steam", monitor = "current" }),
	{ description = "Move to Steam workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + Backspace",
	hl.dsp.workspace.toggle_special("steam"),
	{ description = "Toggle Steam workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + Delete",
	hl.dsp.workspace.move({ workspace = "special:trash", monitor = "current" }),
	{ description = "Move to Trash workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + Delete",
	hl.dsp.workspace.toggle_special("trash"),
	{ description = "Toggle Trash workspace", submap_universal = true }
)
-- hl.bind(mainMod .. " + SHIFT + R", hl.dsp.workspace.move({ workspace = "special:update", monitor = "current" }), { description = "Move to update workspace", submap_universal = true }
hl.bind(
	mainMod .. " + SHIFT + U",
	hl.dsp.workspace.toggle_special("update"),
	{ description = "Toggle update workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + O",
	hl.dsp.workspace.move({ workspace = "special:whatsapp", monitor = "current" }),
	{ description = "Move to Whatsapp workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + O",
	hl.dsp.workspace.toggle_special("whatsapp"),
	{ description = "Toggle Whatsapp workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + 6",
	hl.dsp.workspace.move({ workspace = "special:pulsesecure", monitor = "current" }),
	{ description = "Move to Pulse Secure workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + 6",
	hl.dsp.workspace.toggle_special("pulsesecure"),
	{ description = "Toggle Pulse Secure workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + 7",
	hl.dsp.workspace.move({ workspace = "special:forticlient", monitor = "current" }),
	{ description = "Move to Forticlient workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + 7",
	hl.dsp.workspace.toggle_special("forticlient"),
	{ description = "Toggle Forticlient workspace", submap_universal = true }
)
-- hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.workspace.move({ workspace = "special:ytm", monitor = "current" }), { description = "Move to ytm workspace", submap_universal = true })
-- hl.bind(mainMod .. " + Y", hl.dsp.workspace.togglespecial("ytm"), { description = "Toggle ytm workspace", submap_universal = true })
hl.bind(
	mainMod .. " + SHIFT + I",
	hl.dsp.workspace.move({ workspace = "special:rmpc", monitor = "current" }),
	{ description = "Move to rmpc workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + I",
	hl.dsp.workspace.toggle_special("rmpc"),
	{ description = "Toggle rmpc workspace", submap_universal = true }
)

local function baseWorkspace()
	local m = hl.get_active_monitor()

	if m.name == "HDMI-A-1" then
		return 3
	end
	return 0
end

local function switchWorkspace(s)
	hl.dispatch(hl.dsp.focus({ workspace = baseWorkspace() + s }))
end

local function moveWindowWorkspace(s, follow)
	hl.dispatch(hl.dsp.window.move({
		workspace = baseWorkspace() + s,
		follow = follow,
	}))
end

-- Switch workspaces with SUPER + [0-9]
hl.bind(mainMod .. " + 1", function()
	switchWorkspace(1)
end, { submap_universal = true })

hl.bind(mainMod .. " + 2", function()
	switchWorkspace(2)
end, { submap_universal = true })

hl.bind(mainMod .. " + 3", function()
	switchWorkspace(3)
end, { submap_universal = true })

-- Move active window to workspace
hl.bind(mainMod .. " + CTRL + 1", function()
	moveWindowWorkspace(1)
end, { submap_universal = true })

hl.bind(mainMod .. " + CTRL + 2", function()
	moveWindowWorkspace(2)
end, { submap_universal = true })

hl.bind(mainMod .. " + CTRL + 3", function()
	moveWindowWorkspace(3)
end, { submap_universal = true })

-- Move active window to workspace silent
hl.bind(mainMod .. " + SHIFT + 1", function()
	moveWindowWorkspace(1, false)
end, { submap_universal = true })

hl.bind(mainMod .. " + SHIFT + 2", function()
	moveWindowWorkspace(2, false)
end, { submap_universal = true })

hl.bind(mainMod .. " + SHIFT + 3", function()
	moveWindowWorkspace(3, false)
end, { submap_universal = true })

-- Move/resize windows with SUPER + LMB/RMB and dragging
-- mouse:272 = left
-- mouse:273 = right
-- mouse:274 = middle
-- mouse:275 = side
-- mouse:276 = extra
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.gesture({ fingers = 2, direction = "pinch", action = "cursorZoom", zoom_level = "1", mode = "live" })
hl.gesture({ fingers = 4, direction = "horizontal", action = "scroll_move" })

hl.bind(
	mainMod .. " + mouse:274",
	hl.dsp.window.float({ action = "toggle", window = "activewindow" }),
	{ mouse = true }
)

-- Zoom
hl.bind(mainMod .. " + mouse_down", function()
	local zoomFactor = hl.get_config("cursor.zoom_factor")
	if zoomFactor < 10 then
		hl.config({
			cursor = { zoom_factor = zoomFactor + 0.5 },
		})
	end
end)
hl.bind(mainMod .. " + mouse_up", function()
	local zoomFactor = hl.get_config("cursor.zoom_factor")
	if zoomFactor > 1 then
		hl.config({
			cursor = { zoom_factor = zoomFactor - 0.5 },
		})
	end
end)

-- The second bind is redundant but I'm used to it in DWM
hl.bind(mainMod .. " + SHIFT + CTRL + comma", hl.dsp.workspace.swap_monitors({ monitor1 = "-1", monitor2 = "1" }))
hl.bind(mainMod .. " + SHIFT + CTRL + period", hl.dsp.workspace.swap_monitors({ monitor1 = "1", monitor2 = "+1" }))

hl.bind(
	mainMod .. " + SHIFT + comma",
	hl.dsp.window.move({ monitor = "l" }),
	{ description = "Move to HDMI-A-1 workspace", submap_universal = true }
)
hl.bind(
	mainMod .. " + SHIFT + period",
	hl.dsp.window.move({ monitor = "r" }),
	{ description = "Move to eDP-1 workspace", submap_universal = true }
)

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

-- mark, unmark and focus marked window
hl.bind(
	mainMod .. " + SHIFT + Y",
	hl.dsp.window.tag({ tag = "+mark" }),
	{ description = "Mark focused window", submap_universal = true }
)
hl.bind(
	mainMod .. " + CTRL + Y",
	hl.dsp.window.tag({ tag = "-mark" }),
	{ description = "Mark focused window", submap_universal = true }
)
hl.bind(
	mainMod .. " + Y",
	hl.dsp.focus({ window = "tag:mark" }),
	{ description = "Focus marked window", submap_universal = true }
)

-- laptop lid switch
hl.bind("switch:on:[Lid Switch]", function()
	hl.monitor({ output = "eDP-1", disabled = false, locked = true })
end)
hl.bind("switch:off:[Lid Switch]", function()
	hl.monitor({ output = "eDP-1", disabled = true, locked = true })
end)

-- Plugins
require("scrolling")

-- Source local config for AMD/Nvidia laptop
if getHostname() == "opalMMU" then
	require("localAMD")
else
	require("localNvidia")
end

local startup_cmds = {
	-- Remove button layouts on libadwaita apps. To undo:
	-- gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	"gsettings set org.gnome.desktop.wm.preferences button-layout ':'",
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"jamesdsp --tray",
	-- "hyprpm reload",
	"systemctl --user start vicinae",
	"systemctl --user start hypridle",
	"systemctl --user start foot-server",
	-- "wayscriber --daemon",
	"dms run --session",
}

local shutdown_cmds = {
	"systemctl --user stop hypridle",
	"systemctl --user stop vicinae",
	"systemctl --user stop foot-server",
	"pkill jamesdsp",
	"pkill WhatsApp",
}

hl.on("hyprland.start", function()
	for _, cmd in ipairs(startup_cmds) do
		hl.exec_cmd(cmd)
	end
end)

hl.on("hyprland.shutdown", function()
	for _, cmd in ipairs(shutdown_cmds) do
		hl.exec_cmd(cmd)
	end
end)
