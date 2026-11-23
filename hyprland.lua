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
require("scrolloverview")

local startup_cmds = {
	-- Remove button layouts on libadwaita apps. To undo:
	-- gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	"gsettings set org.gnome.desktop.wm.preferences button-layout ':'",
	"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP",
	"hyprpm reload",
	"systemctl --user start jamesdsp.service",
	"systemctl --user start vicinae.service",
	"systemctl --user start hypridle.service",
	"systemctl --user start cable-uhid-bridge.service",
	"systemctl --user start dms.service",
	"systemctl --user start mmu-vpn-tray.service",
	"systemctl --user start dcal.service",
}

local shutdown_cmds = {
	"systemctl --user stop hypridle.service",
	"systemctl --user stop vicinae.service",
	"systemctl --user stop cable-uhid-bridge.service",
	"systemctl --user stop dms.service",
	"systemctl --user stop jamesdsp.service",
	"systemctl --user stop mmu-vpn-tray.service",
	"systemctl --user stop dcal.service",
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
		hl.exec_cmd("systemctl --user start fievel")
	end
end)

hl.on("hyprland.shutdown", function()
	for _, cmd in ipairs(shutdown_cmds) do
		hl.exec_cmd(cmd)
	end
	if not env.isNvidia then
		hl.exec_cmd("systemctl --user stop fievel")
	end
end)
