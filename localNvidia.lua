-- /etc/modprobe.d/nvidia.conf
-- options nvidia_drm modeset=1
-- options nvidia NVreg_EnableGpuFirmware=1
-- options nvidia NVreg_PreserveVideoMemoryAllocations=1
-- options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PowerMizerDefault=0x1; PowerMizerDefaultAC=0x1; PerfLevelSrc=0x2222"

local mainMod = "SUPER"
local confDir = "/home/opal/.config/hypr"
local scriptsDir = confDir .. "/scripts"
local prime =
"LIBVA_DRIVER_NAME=nvidia __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only __NV_PRIME_RENDER_OFFLOAD=1"

hl.env("NVD_GPU", "0")
hl.env("MOZ_DISABLE_RDD_SANDBOX", "1")
hl.env("MOZ_DRM_DEVICE", "/dev/dri/card0")
hl.env("NVD_BACKEND", "direct")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("VDPAU_DRIVER", "nvidia")
-- hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")

hl.config({
  render = {
    direct_scanout = true,
  },
})

hl.bind(
  mainMod .. " + W",
  hl.dsp.exec_cmd(scriptsDir .. "/hypr-cycle-focus-lua.sh class zen " .. prime .. " zen-browser"),
  { description = "(hypr-cycle-focus) Open Zen Browser" }
)
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(prime .. "zen-browser"), { description = "Open Zen Browser" })

hl.on("hyprland.start", function()
  hl.exec_cmd("sudo setkeycodes e057 240 e058 240")
  hl.exec_cmd("/home/opal/.local/bin/kanata_cmd_allowed -c " .. confDir .. "/kanata/lappy.kbd")
end)

-- DMS brightness binds
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("dms ipc call brightness increment 5 backlight:intel_backlight"),
  { description = "Brightness Up" }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("dms ipc call brightness decrement 5 backlight:intel_backlight"),
  { description = "Brightness Down" }
)
hl.bind(
  "SHIFT + XF86MonBrightnessDown",
  hl.dsp.exec_cmd("dms ipc call brightness toggleExponential backlight:intel_backlight"),
  { description = "Toggle Exponential Brightness" }
)
