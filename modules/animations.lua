hl.curve("easy2", { type = "spring", mass = 1, stiffness = 1000.1191, dampening = 33.9 })
hl.curve("easy", { type = "spring", mass = 1, stiffness = 213.7989, dampening = 25.6978877 })

local spring_animations = {
	{ leaf = "workspacesIn", style = "slidevert", spring = "easy2", speed = 1 },
	{ leaf = "workspacesOut", style = "slidevert", spring = "easy2", speed = 1 },
	{ leaf = "specialWorkspaceIn", style = "slidevert", spring = "easy2", speed = 1 },
	{ leaf = "specialWorkspaceOut", style = "slidevert", spring = "easy2", speed = 1 },
	{ leaf = "windowsIn", style = "popin", spring = "easy2", speed = 1 },
	{ leaf = "windowsOut", style = "slide", spring = "easy2", speed = 1 },
	{ leaf = "layersIn", style = "popin", spring = "easy2", speed = 1 },
	{ leaf = "layersOut", style = "popin", spring = "easy2", speed = 1 },
}

for _, a in ipairs(spring_animations) do
	hl.animation({
		leaf = a.leaf,
		enabled = true,
		speed = a.speed or 3,
		spring = a.spring,
		style = a.style,
	})
end

local curves = {
	simple = { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } },
	smooth = { type = "bezier", points = { { 0.25, 0.1 }, { 0.35, 0.15 } } },
	smoothOut = { type = "bezier", points = { { 0.36, 0 }, { 0.66, -0.56 } } },
	smoothIn = { type = "bezier", points = { { 0.25, 1 }, { 0.5, 1 } } },
	linear = { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } },
	myBezier = { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } },
	overshot = { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } },
	cubic = { type = "bezier", points = { { 0.54, 0.22 }, { 0.07, 0.74 } } },
	overshotCircle = { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } },
	md3_standard = { type = "bezier", points = { { 0.2, 0.0 }, { 0, 1.0 } } },
	bounce = { type = "bezier", points = { { 1, 1.6 }, { 0.1, 0.85 } } },
	decel = { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } },
	quick = { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } },
	easeoutexpo = { type = "bezier", points = { { 0.87, 0 }, { 0.13, 1 } } },
	easeoutquad = { type = "bezier", points = { { 0.45, 0 }, { 0.55, 1 } } },
}

for name, curve in pairs(curves) do
	hl.curve(name, curve)
end

local bezier_animations = {
	{ leaf = "zoomFactor", speed = 7, bezier = "quick" },
	{ leaf = "windowsMove", style = "slide 90%", bezier = "md3_standard", speed = 3 },
	{ leaf = "border", bezier = "overshot", speed = 10 },
	{ leaf = "borderangle", style = "loop", bezier = "linear", speed = 100 },
}

for _, a in ipairs(bezier_animations) do
	hl.animation({
		leaf = a.leaf,
		enabled = true,
		speed = a.speed or 3,
		bezier = a.bezier,
		style = a.style,
	})
end

local fade_leaves = {
	"fadeIn",
	"fadeOut",
	"fadeSwitch",
	"fadeShadow",
	"fadeDim",
	"fadeLayersIn",
	"fadeLayersOut",
	"fadePopupsIn",
	"fadePopupsOut",
	"fadeDpms",
}

for _, leaf in ipairs(fade_leaves) do
	hl.animation({
		leaf = leaf,
		enabled = true,
		speed = 3,
		bezier = "smooth",
	})
end
