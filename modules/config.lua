require("mocha")

local env = require("modules.env")

local cfg = {
	input = {
		kb_layout = "us",
		kb_variant = "altgr-intl",
		special_fallthrough = true,
		follow_mouse = 1,
		numlock_by_default = true,
		repeat_rate = 25,
		repeat_delay = 600,
		focus_on_close = 2,
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
		font_family = "OpalBSDAile Nerd Font Propo",
		on_focus_under_fullscreen = 1,
	},

	cursor = {
		hide_on_touch = true,
		hide_on_key_press = true,
		persistent_warps = true,
		warp_back_after_non_mouse_input = true,
		warp_on_change_workspace = 1,
		warp_on_toggle_special = 1,
		default_monitor = "HDMI-A-1",
		no_hardware_cursors = 2,
		use_cpu_buffer = 2,
		zoom_rigid = true,
	},

	binds = {
		workspace_back_and_forth = true,
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
		gaps_in = 1,
		gaps_out = 3,
		border_size = 3,
		resize_on_border = false,
		col = {
			active_border = mauve,
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
			border_active = mauve,
			border_locked_active = mauve,
			border_inactive = "rgba(00000000)",
			border_locked_inactive = "rgba(00000000)",
		},

		groupbar = {
			keep_upper_gap = false,
			indicator_height = 9,
			blur = true,
			gradients = false,
			render_titles = false,
			rounding = 5,
			rounding_power = 5.0,
			gaps_in = 3,
			disable_when_only = true,
			col = {
				active = mauve,
				locked_inactive = blue,
				locked_active = mauve,
			},
		},
	},

	decoration = {
		rounding = 5,
		rounding_power = 5.0,
		active_opacity = 1.0,
		fullscreen_opacity = 1.0,

		motion_blur = {
			enabled = true,
		},

		blur = {
			size = 1,
			passes = 5,
			vibrancy = 0.1696,
			new_optimizations = true,
			popups = true,
			-- proportional = true,
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
		expand_undersized_textures = false,
	},

	master = {
		new_status = "slave",
		mfact = 0.5,
		special_scale_factor = 0.9,
		allow_small_split = true,
		new_on_active = "after",
	},
}

if env.isNvidia then
	cfg.render.direct_scanout = true
end

hl.config(cfg)
