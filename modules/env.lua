local M = {}

local function getHostname()
	local f = io.popen("/bin/hostnamectl hostname")
	if f == nil then
		return ""
	end
	local hostname = f:read("*a") or ""
	f:close()
	return (string.gsub(hostname, "\n$", ""))
end

M.hostname = getHostname()
M.isNvidia = M.hostname ~= "opalMMU"
M.home = os.getenv("HOME") or "/home/opal"
M.confDir = M.home .. "/.config/hypr"

local nvidia_env = {
	LIBVA_DRIVER_NAME = "nvidia",
	__GLX_VENDOR_LIBRARY_NAME = "nvidia",
	__VK_LAYER_NV_optimus = "NVIDIA_only",
	__NV_PRIME_RENDER_OFFLOAD = "1",
}

local function build_prefix(vars, skip)
	local parts = {}
	for key, value in pairs(vars) do
		if key ~= skip then
			parts[#parts + 1] = key .. "=" .. value
		end
	end
	return table.concat(parts, " ")
end

M.envExec = M.isNvidia and (build_prefix(nvidia_env) .. " ") or ""

local envs = {
	_JAVA_AWT_WM_NONREPARENTING = "1",
	QT_QPA_PLATFORMTHEME = "gtk3",
	QT_QPA_PLATFORMTHEME_QT6 = "gtk3",
	QT_QPA_PLATFORM = "wayland",
	QT_AUTO_SCREEN_SCALE_FACTOR = "1",
	QT_ENABLE_HIGHDPI_SCALING = "1",
	QT_SCALE_FACTOR_ROUNDING_POLICY = "RoundPreferFloor",
	QT_WAYLAND_DISABLE_WINDOWDECORATION = "1",
	MOZ_ENABLE_WAYLAND = "1",
	GDK_BACKEND = "wayland,x11,*",
	PATH = M.home
		.. "/.local/bin:"
		.. M.confDir
		.. "/scripts:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin",
	GAMEMODERUNEXEC = "env " .. build_prefix(nvidia_env, "LIBVA_DRIVER_NAME"),
	ELECTRON_OZONE_PLATFORM_HINT = "auto",
	HYPRCURSOR_THEME = "catppuccin-mocha-mauve-cursors",
	HYPRCURSOR_SIZE = "24",
	XCURSOR_THEME = "catppuccin-mocha-mauve-cursors",
	XCURSOR_SIZE = "24",
	HYPRLAND_NO_CRASHREPORTER = "1",
	XDG_CURRENT_DESKTOP = "Hyprland",
	XDG_SESSION_TYPE = "wayland",
	XDG_SESSION_DESKTOP = "Hyprland",
	TERMINAL = "kitty",
	GTK_USE_PORTAL = "1",
	GTK_DECORATION_LAYOUT = "",
}

for key, value in pairs(envs) do
	hl.env(key, value)
end

if M.isNvidia then
	local nvidia_global_env = {
		NVD_GPU = "0",
		MOZ_DISABLE_RDD_SANDBOX = "1",
		MOZ_DRM_DEVICE = "/dev/dri/card0",
		NVD_BACKEND = "direct",
		LIBVA_DRIVER_NAME = nvidia_env.LIBVA_DRIVER_NAME,
		__GLX_VENDOR_LIBRARY_NAME = nvidia_env.__GLX_VENDOR_LIBRARY_NAME,
		VDPAU_DRIVER = "nvidia",
		-- AQ_DRM_DEVICES = "/dev/dri/card0:/dev/dri/card1",
	}

	for key, value in pairs(nvidia_global_env) do
		hl.env(key, value)
	end
end

return M
