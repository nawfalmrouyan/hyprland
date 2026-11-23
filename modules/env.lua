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

-- Keep the `env` executable in front of the assignments so the command can be
-- wrapped by uwsm, e.g. `uwsm app -- env LIBVA_DRIVER_NAME=nvidia kitty`.
M.envExec = M.isNvidia and ("env " .. build_prefix(nvidia_env) .. " ") or ""

return M
