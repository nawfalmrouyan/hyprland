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
	{ "_JAVA_AWT_WM_NONREPARENTING", "1" },
	{ "QT_QPA_PLATFORMTHEME", "gtk3" },
	{ "QT_QPA_PLATFORMTHEME_QT6", "gtk3" },
	{ "QT_QPA_PLATFORM", "wayland" },
	{ "QT_AUTO_SCREEN_SCALE_FACTOR", "1" },
	{ "QT_WAYLAND_DISABLE_WINDOWDECORATION", "1" },
	{ "MOZ_ENABLE_WAYLAND", "1" },
	{ "GDK_BACKEND", "wayland,x11,*" },
	{
		"PATH",
		"/home/opal/.local/bin:/home/opal/.config/hypr/scripts:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin",
	},
	{
		"GAMEMODERUNEXEC",
		"env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only",
	},
	{ "ELECTRON_OZONE_PLATFORM_HINT", "auto" },
	{ "HYPRCURSOR_THEME", "catppuccin-mocha-mauve-cursors" },
	{ "HYPRCURSOR_SIZE", "24" },
	{ "XCURSOR_THEME", "catppuccin-mocha-mauve-cursors" },
	{ "XCURSOR_SIZE", "24" },
	{ "HYPRLAND_NO_CRASHREPORTER", "1" },
	{ "XDG_CURRENT_DESKTOP", "Hyprland" },
	{ "XDG_SESSION_TYPE", "wayland" },
	{ "XDG_SESSION_DESKTOP", "Hyprland" },
	{ "TERMINAL", "kitty" },
	{ "GTK_USE_PORTAL", "1" },
}

for _, env in ipairs(envs) do
	hl.env(env[1], env[2])
end

require("split-monitor-workspaces")

local on_created_empty = {
	{
		workspace = "special:terminal",
		cmd = "kitty --class=scratch -T scratch -e sesh connect WORK",
	},
	{
		workspace = "special:trash",
		cmd = "youtube-music-for-desktop",
	},
	{
		workspace = "special:whatsapp",
		cmd = "/home/opal/.config/WhatsAppWeb-linux-x64/WhatsAppWeb --ozone-platform-hint=auto --enable-features=WebRTCPipeWireCapturer",
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
		cmd = "kitty -1 --class=update -T update -e pulsemixer",
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
		cmd = "kitty -1 -T ytm -e rmpc",
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

		motion_blur = {
			enabled = true,
		},

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

	render = {
		new_render_scheduling = true,
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

local curves = {
	simple = { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } },
	smooth = { type = "bezier", points = { { 0.25, 0.1 }, { 0.35, 0.15 } } },
	smoothOut = { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } },
	smoothIn = { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } },
	linear = { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } },
	myBezier = { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } },
	overshot = { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } },
	cubic = { type = "bezier", points = { { 0.54, 0.22 }, { 0.07, 0.74 } } },
	overshotCircle = { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } },
	md3_standard = { type = "bezier", points = { { 0.2, 0.0 }, { 0, 1.0 } } },
	bounce = { type = "bezier", points = { { 1, 1.6 }, { 0.1, 0.85 } } },
	decel = { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } },
	quick = { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } },
	easeoutexpo = { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } },
	easeoutquad = { type = "bezier", points = { { 0.45, 0 }, { 0.55, 1 } } },
}

for name, curve in pairs(curves) do
	hl.curve(name, curve)
end

hl.curve("easy", {
	type = "spring",
	mass = 1,
	stiffness = 71.2633,
	dampening = 15.8273644,
})

local animations = {
	{ leaf = "layersIn", style = "slide 90%", bezier = "bounce", speed = 3 },
	{ leaf = "layersOut", style = "slide 90%", bezier = "bounce", speed = 3 },

	{ leaf = "zoomFactor", speed = 7, bezier = "quick" },

	{ leaf = "windowsIn", style = "popin 85%", bezier = "bounce", speed = 3 },
	{ leaf = "windowsOut", style = "popin 85%", bezier = "bounce", speed = 3 },
	{ leaf = "windowsMove", style = "slide 90%", bezier = "md3_standard", speed = 3 },

	{ leaf = "border", bezier = "overshot", speed = 10 },

	{ leaf = "borderangle", style = "loop", bezier = "linear", speed = 100 },

	{ leaf = "workspacesIn", style = "slidevert 90%", bezier = "bounce", speed = 3 },
	{ leaf = "workspacesOut", style = "slidevert 90%", bezier = "bounce", speed = 3 },
	{ leaf = "specialWorkspaceIn", style = "slidevert 90%", bezier = "bounce", speed = 3 },
	{ leaf = "specialWorkspaceOut", style = "slidevert 90%", bezier = "bounce", speed = 3 },
}

for _, a in ipairs(animations) do
	hl.animation({
		leaf = a.leaf,
		enabled = true,
		speed = a.speed or 3,
		bezier = a.bezier,
		style = a.style,
	})
end

local fade_leaves = {
	"fadeIn",
	"fadeOut",
	"fadeSwitch",
	"fadeShadow",
	"fadeDim",
	"fadeLayersIn",
	"fadeLayersOut",
	"fadePopupsIn",
	"fadePopupsOut",
	"fadeDpms",
}

for _, leaf in ipairs(fade_leaves) do
	hl.animation({
		leaf = leaf,
		enabled = true,
		speed = 3,
		bezier = "smooth",
	})
end

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
		match = { class = "^(kitty|kittyterminal|footclient)$" },
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
		border_color = { colors = { mauve, blue }, angle = 45 },
		match = { float = true },
	},

	{
		border_size = 0,
		match = { fullscreen = true },
	},

	{
		border_size = 0,
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
			class = "whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|steam|com.rtosta.zapzap",
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

local exec_cmd = {
	-- terminals / apps
	{
		key = "SHIFT + T",
		cmd = "kitty -1 -T Projects -e sesh connect Projects",
		desc = "Open Terminal with TMUX session:Projects",
	},
	{
		key = "Return",
		cmd = "kitty -1 -e sesh connect stuff",
		desc = "Open Terminal with TMUX session:stuff",
	},
	{
		key = "SHIFT + Return",
		cmd = "kitty -1 -e sesh connect stuff",
		desc = "Open Terminal with TMUX session:stuff",
	},
	{
		key = "SHIFT + E",
		cmd = "nautilus",
		desc = "Open Nautilus",
	},
	{
		key = "CTRL + E",
		cmd = "kitty -1 -e yazi",
		desc = "Open yazi",
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
		cmd = "kitty -1 -T PowerShell -e sesh connect PowerShell",
		desc = "Open Terminal with TMUX session:PowerShell",
	},

	-- rofi / vicinae
	{
		key = "0",
		cmd = "ROFI_PASS_CONFIG='" .. confDir .. "/rofi-pass/config' rofi-pass",
		desc = "Open rofi-pass",
	},
	-- {
	-- 	key = "SHIFT + U",
	-- 	cmd = "rofi-beats",
	-- 	desc = "Open Rofi Radio Stream",
	-- },
	{
		key = "Grave",
		cmd = "vicinae vicinae://launch/wm/switch-windows",
		desc = "Vicinae Switch windows",
	},
	{
		key = "E",
		-- cmd = "vicinae vicinae://launch/core/search-emojis",
		-- desc = "Vicinae Search Emojis",
		cmd = "kitty -1 -T explorer -e yazi",
		desc = "Open yazi",
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
	-- {
	-- 	key = "SHIFT + Z",
	-- 	cmd = "pkill -SIGUSR1 wayscriber",
	-- 	desc = "Toggle wayscriber",
	-- },
	{ key = "N", cmd = "nvim-hypr-anywhere.sh", desc = "Open nvim-hypr-anywhere" },
	{ key = "B", cmd = "kitty -1 -T btop -e btop", desc = "Open btop" },
	{ key = "SHIFT + N", cmd = "kitty -1 -T btop -e nvtop", desc = "Open nvtop" },
	{ key = "X", cmd = "dms ipc call bar toggle index 0", desc = "Toggle dank bar" },
	{
		key = "8",
		-- cmd = "foot -c /home/opal/.config/foot/foot-anywhere.ini -a toipe -e toofan",
		cmd = "kitty --class=toipe --config=/home/opal/.config/kitty/kitty-anywhere.conf -e toofan",
		desc = "Open Toofan (typing test)",
	},

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
	end
	hl.bind(mainMod .. " + " .. b.key, hl.dsp.exec_cmd(b.cmd), opts)
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

-- local dispatch_group = {
-- 	{
-- 		key = "Tab",
-- 		action = hl.dsp.group.next(),
-- 		desc = "Cycle windows in a group",
-- 	},
-- }
--
-- for _, b in ipairs(dispatch_group) do
-- 	hl.bind(mainMod .. " + " .. b.key, b.action, { description = b.desc, universal_submap = true })
-- end

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
	-- update = { key = "Y" },
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

	-- move to special workspace (NOW includes terminal too)
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
	mainMod .. " + mouse_down",
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

-- The second bind is redundant but I'm used to it in DWM
hl.bind(mainMod .. " + SHIFT + CTRL + comma", hl.dsp.workspace.swap_monitors({ monitor1 = "-1", monitor2 = "1" }))
hl.bind(mainMod .. " + SHIFT + CTRL + period", hl.dsp.workspace.swap_monitors({ monitor1 = "1", monitor2 = "+1" }))

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

local class_binds = {
	{ key = "W", class = "zen", exec = "zen-browser" },
	{ key = "T", class = "kittyterminal", exec = "kitty -1 --class=kittyterminal -e sesh connect stuff" },
	{
		key = "R",
		class = "teams-for-linux",
		exec = "/opt/teams-for-linux/teams-for-linux --ozone-platform-hint=auto",
	},
	{ key = "A", class = "outlook-for-linux", exec = "/opt/outlook-for-linux/outlook-for-linux" },
	{ key = "Z", class = "Apache Directory Studio", exec = "/opt/ApacheDirectoryStudio/ApacheDirectoryStudio" },
	{
		key = "SHIFT + A",
		class = "brave-browser",
		exec = "brave -enable-features=UseOzonePlatform -ozone-platform=wayland",
	},
}

focus = require("cycle")

for _, b in ipairs(class_binds) do
	hl.bind(mainMod .. " + " .. b.key, function()
		focus.cycle(b)
	end, {
		description = "Cycle focus by class: " .. b.class,
	})
end

hl.bind(mainMod .. " + Tab", function()
	local c = {}
	c.class = hl.get_active_window().class
	c.exec = ""
	-- hl.notification.create({ text = "class: " .. c, duration = 2000 })
	focus.cycle(c)
end, {
	description = "Cycle focus by current window's class",
	repeating = true,
})

local title_binds = {
	{
		key = "S",
		title = "PowerShell",
		exec = "kitty -1 --class=kittyterminal -T PowerShell -e sesh connect PowerShell",
	},
}

for _, b in ipairs(title_binds) do
	hl.bind(mainMod .. " + " .. b.key, function()
		focus.cycle(b)
	end, {
		description = "Cycle focus by title: " .. b.title,
	})
end

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
	-- "systemctl --user start foot-server",
	-- "wayscriber --daemon",
	"dms run --session",
	-- "hyprctl plugin load /home/opal/Projects/hyprview/hyprview.so",
}

local shutdown_cmds = {
	"systemctl --user stop hypridle",
	"systemctl --user stop vicinae",
	-- "systemctl --user stop foot-server",
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

-- require("hyprview")
