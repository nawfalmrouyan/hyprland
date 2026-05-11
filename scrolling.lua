hl.config({
    scrolling = {
        column_width = 0.75,
        fullscreen_on_one_column = false,
        explicit_column_widths = "0.25, 0.5, 0.75, 1.0",
        focus_fit_method = 1,
        follow_min_visible = 0.20,
    },
})

local mainMod = "SUPER"

local directions = {
    L = "r",
    H = "l",
    K = "u",
    J = "d",
}

-- layout focus
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.layout("focus " .. dir))
end

-- swap columns
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.layout("swapcol " .. dir))
end

-- move windows
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- move into/create group
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ into_or_create_group = dir }))
end

-- move out of group
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + SHIFT + ALT + " .. key, hl.dsp.window.move({ out_of_group = dir }))
end

local layout_binds = {
    { "Home",          "fit tobeg" },
    { "End",           "fit toend" },
    { "Equal",         "colresize +conf" },
    { "Minus",         "colresize -conf" },
    { "Comma",         "move -col" },
    { "Period",        "move +col" },
    { "Slash",         "expel r" },
    { "SHIFT + Slash", "expel l" },
    { "BracketLeft",   "consume r" },
    { "BracketRight",  "consume l" },
    { "D",             "fit visible" },
    { "C",             "fit active" },
    { "SHIFT + D",     "inhibit_scroll" },
}

for _, bind in ipairs(layout_binds) do
    hl.bind(mainMod .. " + " .. bind[1], hl.dsp.layout(bind[2]))
end
