require("mocha")

local env = require("modules.env")
local uwsm = require("modules.uwsm")

require("split-monitor-workspaces")
require("modules.config")
require("modules.animations")
require("modules.rules")
require("modules.binds")

-- Plugins
require("scrolling")
require("wl-kbptr")
require("scrolloverview")

hl.on("hyprland.start", function()
	-- Remove button layouts on libadwaita apps. To undo:
	-- gsettings set org.gnome.desktop.wm.preferences button-layout 'appmenu:minimize,maximize,close'
	hl.exec_cmd("gsettings set org.gnome.desktop.wm.preferences button-layout ':'")
	hl.exec_cmd("hyprpm reload")

	if env.isNvidia then
		hl.exec_cmd("sudo setkeycodes e057 240 e058 240")
		hl.exec_cmd(uwsm.session(env.home .. "/.local/bin/kanata_cmd_allowed -c " .. env.confDir .. "/kanata/lappy.kbd"))
	end
end)
