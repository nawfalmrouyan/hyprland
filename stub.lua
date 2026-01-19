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

    -- glow {
    --   enabled = true,
    --   range = 11,
    --   render_power = 2,
    --   color = mauve,
    -- },
  },
})
