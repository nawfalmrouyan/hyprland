require("mocha")

local env = require("modules.env")

require("split-monitor-workspaces")
require("modules.config")
require("modules.animations")
require("modules.rules")
require("modules.binds")

-- Plugins
require("scrolling")
require("wl-kbptr")
-- require("scrolloverview")

local startup_cmds = {
	-- Remove button layouts on libadwaita apps. To undo:
	-- gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	"gsettings set org.gnome.desktop.wm.preferences button-layout ':'",
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"jamesdsp --tray",
	"hyprpm reload",
	"systemctl --user start vicinae",
	"systemctl --user start hypridle",
	"systemctl --user start cable-uhid-bridge.service",
	"dms run --session",
}

local shutdown_cmds = {
	"systemctl --user stop hypridle",
	"systemctl --user stop vicinae",
	"systemctl --user stop cable-uhid-bridge.service",
	"pkill jamesdsp",
	"pkill WhatsApp",
}

hl.on("hyprland.start", function()
	for _, cmd in ipairs(startup_cmds) do
		hl.exec_cmd(cmd)
	end
	if env.isNvidia then
		hl.exec_cmd("sudo setkeycodes e057 240 e058 240")
		hl.exec_cmd(env.home .. "/.local/bin/kanata_cmd_allowed -c " .. env.confDir .. "/kanata/lappy.kbd")
	else
		hl.exec_cmd("fievel")
	end
end)

hl.on("hyprland.shutdown", function()
	for _, cmd in ipairs(shutdown_cmds) do
		hl.exec_cmd(cmd)
	end
	if not env.isNvidia then
		hl.exec_cmd("pkill fievel")
	end
end)
