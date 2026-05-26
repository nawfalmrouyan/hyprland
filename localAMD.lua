local mainMod = "SUPER"
local confDir = "/home/opal/.config/hypr"

local focus = require("modules.cycle")

local class_binds = {
	{ key = "W", class = "zen", exec = "zen-browser" },
}

for _, b in ipairs(class_binds) do
	hl.bind(mainMod .. " + " .. b.key, function()
		focus.cycle(b)
	end, {
		description = "Cycle focus by class: " .. b.class,
	})
end

hl.bind(
  "xf86calculator",
  hl.dsp.exec_cmd("vicinae vicinae://launch/calculator/history"),
  { description = "Vicinae Calculator" }
)
-- hl.bind("xf86favourites", hl.dsp.exec_cmd("remmina"), { description = "Open Remmina" })
-- hl.bind("xf86pickupphone", hl.dsp.workspace.toggle_special("whatsapp"), { description = "Toggle Whatsapp workspace" })
-- hl.bind("xf86hangupphone", hl.dsp.workspace.toggle_special("trash"), { description = "Toggle Trash workspace" })

hl.bind(
  mainMod .. " + W",
  hl.dsp.exec_cmd("hypr-cycle-focus-lua.sh class zen zen-browser"),
  { description = "Open Zen Browser (hypr-cycle-focus)" }
)

hl.on("hyprland.start", function()
  hl.exec_cmd("kanata_cmd_allowed -c " .. confDir .. "/kanata/silakka.kbd")
  -- hl.exec_cmd(localBin .. "kanata_cmd_allowed -c " .. confDir .. "/kanata/lappy.kbd")
end)

-- DMS brightness binds
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd(
    "dms ipc call brightness increment 5 backlight:amdgpu_bl1; dms ipc call brightness increment 5 ddc-i2c-4"
  ),
  { description = "Increase brightness" }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd(
    "dms ipc call brightness decrement 5 backlight:amdgpu_bl1; dms ipc call brightness decrement 5 ddc-i2c-4"
  ),
  { description = "Decrease brightness" }
)
hl.bind(
  "SHIFT + XF86MonBrightnessDown",
  hl.dsp.exec_cmd(
    "dms ipc call brightness toggleExponential backlight:amdgpu_bl1; dms ipc call brightness toggleExponential ddc:i2c-4"
  ),
  { description = "Toggle exponential brightness" }
)
