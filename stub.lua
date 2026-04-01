hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "gtk3")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("PATH", "$HOME/.bun/bin:$HOME/.local/bin:$HOME/.cargo/bin:$confDir/scripts:$PATH")
hl.env(
	"GAMEMODERUNEXEC",
	"env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only"
)
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRLAND_NO_CRASHREPORTER", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("TERMINAL", "footclient")
hl.env("GTK_USE_PORTAL", "1")
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("XCURSOR_THEME", "catppuccin-mocha-mauve-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")

local mainMod = "SUPER"
local home = "/home/opal"
local localBin = home .. "/.local/bin"
local confDir = home .. "/.config/hypr"
local scriptsDir = confDir .. "/scripts"
local volume = scriptsDir .. "/volume"
local backlight = "/bin/brightnessctl"
local screenshot = scriptsDir .. "/dms-screenshot"
local rofi_beats = scriptsDir .. "/rofi-beats"
local music = "youtube-music-for-desktop"

hl.monitor({ output = "HDMI-A-1", mode = "1920x1080", position = "1920x0", scale = 1 })
hl.monitor({ output = "eDP-1", mode = "1920x1080", position = "0x0", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
-- hl.monitor({ output = "name", disabled = true })
-- hl.monitor({ output = "HDMI-A-1", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1"})

hl.workspace_rule({ workspace = 1, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 2, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 3, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 4, monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 5, monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 6, monitor = "HDMI-A-1" })

require("mocha")

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		kb_options = "compose:menu,level3:ralt_switch",
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
			drag_lock = true,
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
		disable_logs = false,
	},

	general = {
		gaps_in = 0,
		gaps_out = 0,
		border_size = 3,
		resize_on_border = true,
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
			window_gap = 5,
			monitor_gap = 5,
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

	decoration = {
		rounding = 0,
		active_opacity = 1.0,
		-- inactive_opacity = 0.9,
		fullscreen_opacity = 1.0,
		-- dim_inactive = true,
		dim_strength = 0.7,
		dim_special = 0.3,
		dim_around = 0.5,

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

	master = {
		new_status = "slave",
		mfact = 0.5,
		special_scale_factor = 0.9,
		allow_small_split = true,
		new_on_active = "after",
	},

	xwayland = {
		force_zero_scaling = true,
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

hl.layer_rule({
	match = { namespace = "rofi|logout_dialog|vicinae" },
	dim_around = true,
	blur = true,
	animation = "popin",
})

hl.layer_rule({
	match = { namespace = "ghostty-quick-terminal|kitty-quick-access" },
	blur = "on",
	above_lock = 2,
	no_screen_share = "on",
})

hl.layer_rule({
	match = { namespace = "swaync.*|dms.*" },
	no_screen_share = "on",
})

hl.layer_rule({
	match = { namespace = "dms.bar" },
	no_screen_share = "off",
})

hl.layer_rule({
	match = { namespace = "hyprhalt" },
	blur = "on",
	ignore_alpha = 0,
})

hl.window_rule({
	name = "term window width",
	match = { class = "^(kitty|footclient)$" },
	scrolling_width = 0.5,
})

hl.window_rule({
	name = "pulse-secure-rules",
	match = { class = "pulseUI", title = "(Pulse Secure)" },
	float = "on",
	center = "on",
	size = { 900, 750 },
	workspace = "special:pulsesecure",
})

hl.window_rule({
	name = "forticlient-rules",
	match = { initial_class = "FortiClient" },
	float = "on",
	center = "on",
	size = { 900, 750 },
	workspace = "special:forticlient",
})

hl.window_rule({
	name = "chatapp-rules",
	match = { initial_class = "com.rtosta.zapzap|whatsappweb-nativefier-d40211|org.telegram.desktop" },
	float = "on",
	center = "on",
	size = { 1600, 960 },
	workspace = "special:whatsapp silent",
})

hl.window_rule({
	name = "youtube-music-rules",
	match = { class = "com.github.th_ch.youtube_music|spotube|(YouTube Music for Desktop)" },
	float = "on",
	center = "on",
	size = { 1600, 960 },
	workspace = "special:trash silent",
})

hl.window_rule({
	name = "showmethekey-rules",
	match = { class = "showmethekey-gtk" },
	move = { 1511, 919 },
	float = "on",
	border_size = 0,
	opacity = "1.0 override 1.0 override",
	no_blur = "on",
	no_focus = "on",
	no_anim = "on",
	no_shadow = "on",
})

hl.window_rule({
	name = "onlyoffice-popups",
	match = { float = "true", class = "DesktopEditors" },
	center = "on",
})

hl.window_rule({
	name = "center-float-windows-class",
	match = { class = "toipe|jamesdsp|hyprland-share-picker|nm-connection-editor|pavucontrol|Gimp|org.quickshell" },
	float = "on",
	center = "on",
	size = { 900, 750 },
})

hl.window_rule({
	name = "persistent-size-windows",
	match = { class = "qt5ct|qt6ct|feh|FortiClient|yad" },
	float = "on",
	center = "on",
	-- persistent_size = on
})

-- hl.window_rule({
--   name = "satty-window
--   match = { class = com.gabm.satty
--   float = on
--   center = on
--   min_size = 730 300
-- })

hl.window_rule({
	name = "center-float-windows-title",
	match = { title = "Settings|Hyprshot|Open|(Publish as PDF or XPS|^Settings - .*|^Warning:.*)" },
	float = "on",
	center = "on",
	size = { 900, 750 },
})

-- grouping rules
hl.window_rule({
	group = "set",
	match = {
		class = "whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|com.rtosta.zapzap|FortiClient|pulseUI",
	},
})
hl.window_rule({ group = "override barred", match = { class = "foot|kitty|zen|xdg-desktop-portal-gtk" } })

-- misc rules
hl.window_rule({ center = "on", match = { title = "LibreOffice" } })
hl.window_rule({ tile = "on", match = { class = "ONLYOFFICE" } })
hl.window_rule({ float = "on", match = { title = ".*Network Manager.*" } })

hl.window_rule({ border_color = "$mauve $red", match = { float = true } })
hl.window_rule({ border_size = 0, match = { fullscreen = true } })
hl.window_rule({ border_size = 0, match = { fullscreen_state_internal = 1, fullscreen_state_client = 2 } })
hl.window_rule({ opacity = { 0.8, 0.8 }, match = { pin = true } })

hl.window_rule({
	name = "steam-window",
	match = { class = "steam" },
	float = "on",
})

hl.window_rule({ float = "on", match = { class = "^(steam_app_.*)$, match:initial_title ^(..+)$" } })

hl.window_rule({
	name = "steam",
	match = { class = "steam", title = "Steam|(Sign in to Steam)" },
	workspace = "special:steam silent",
	float = "on",
	center = "on",
	size = { 1600, 960 },
})

hl.window_rule({
	name = "torchlight2",
	match = { class = "Torchlight2.bin.x86_64", title = "(Torchlight II v.25.5.4)" },
	fullscreen = "on",
	content = "game",
})

-- teams rules
hl.window_rule({
	name = "idle-inhibit-apps",
	match = { class = "teams-for-linux" },
	idle_inhibit = "focus",
})

-- zen rules
hl.window_rule({
	name = "zen-pip-rules",
	match = { class = "zen", title = "Picture-in-Picture" },
	float = "on",
	max_size = { 800, 800 },
})

hl.window_rule({
	name = "noscreenshare-rules",
	match = {
		class = "whatsappweb-nativefier-d40211|org.telegram.desktop|spotube|com.github.th_ch.youtube_music|steam|com.rtosta.zapzap",
	},
	no_screen_share = "on",
})

hl.window_rule({
	name = "noscreenshare-terminal",
	match = { title = "noscreenshare" },
	no_screen_share = "on",
})

hl.window_rule({
	name = "center-float-app",
	match = { class = "waypaper|qt6ct|qt5ct" },
	float = "on",
	size = { 900, 750 },
	center = "on",
})

hl.window_rule({
	name = "picker-title-rules",
	match = { title = "([Ff]ile Upload)|(Enter name of file to save to.*)|(blob.*)|(Open [Ff]iles)|(Open folder.*)" },
	size = { 1345, 720 },
	float = "on",
	center = "on",
})

hl.window_rule({
	float = "on",
	size = { 1345, 720 },
	center = "on",
	match = { class = "(soffice|Save Image|Save As|xdg-desktop-portal-gtk)" },
})

hl.window_rule({
	name = "waybar-popups",
	match = { initial_class = "(blueman-manager)|(com.network.manager)" },
	animation = "slide",
	stay_focused = "on",
	float = "on",
	size = { 1280, 700 },
	move = { 380, 35 },
})

-- xwaylandvideobridge
hl.window_rule({
	name = "xwaylandvideobridge",
	match = { class = "xwaylandvideobridge" },
	opacity = "0.0 override 0.0 override",
	no_anim = "on",
	no_focus = "on",
	no_initial_focus = "on",
	workspace = "special:junks silent",
})

-- waybar yay update click, cava
hl.window_rule({
	name = "tui-window",
	match = { class = "update", title = "update" },
	animation = "slide",
	float = "on",
	size = { 1280, 700 },
	move = { 380, 43 },
	workspace = "special:update",
})

hl.window_rule({
	name = "config-window",
	match = { class = "org.netrs.ui" },
	animation = "slide",
	float = "on",
	size = { 1280, 700 },
	move = { 380, 35 },
})

-- firefox textern
-- ["kitty", "--class", "kitty", "--title", "textern", "-e", "/home/opal/.local/bin/av", "+call cursor(%l,%c)"]
hl.window_rule({
	name = "textern-window",
	match = { class = "foot", title = "textern" },
	animation = "slide",
	float = "on",
	pin = "on",
	size = { 1280, 700 },
	center = "on",
})

hl.window_rule({
	name = "nvim-hypr-anywhere",
	match = { class = "nvim-hypr-anywhere" },
	animation = "slide",
	float = "on",
	pin = "on",
	size = { 1280, 700 },
	center = "on",
})

hl.window_rule({
	name = "stats-window",
	match = { initial_title = "btop" },
	animation = "popin",
	float = "on",
	pin = "on",
	size = { 1280, 700 },
	center = "on",
})

hl.window_rule({
	name = "ytm",
	match = { initial_title = "ytm" },
	animation = "popin",
	size = { 1280, 700 },
	float = "on",
	center = "on",
})

hl.window_rule({
	name = "terminal-scratchpad",
	match = { class = "scratch", title = "scratch" },
	animation = "slide",
	float = "on",
	size = { 1440, 700 },
	move = { 240, 377 },
})

hl.window_rule({
	name = "no-focus-window",
	match = { title = "^(Peek preview)$" },
	no_focus = "on",
})

hl.window_rule({
	name = "enable-tearing",
	match = { title = "(Grim Dawn)" },
	immediate = "on",
	content = "game",
})

hl.window_rule({
	name = "suppressevent-maximize",
	match = { class = ".*" },
	suppress_event = "maximize",
})
