hl.config({
    scrolling = {
        column_width = 0.75,
        fullscreen_on_one_column = true,
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

local dir_names = {
    r = "right",
    l = "left",
    u = "up",
    d = "down",
}

-- layout focus
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + " .. key, hl.dsp.layout("focus " .. dir), {
        description = "Focus window " .. dir_names[dir],
    })
end

-- swap columns
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.layout("swapcol " .. dir), {
        description = "Swap column " .. dir_names[dir],
    })
end

-- move windows
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }), {
        description = "Move window " .. dir_names[dir],
    })
end

-- move into/create group
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ into_or_create_group = dir }), {
        description = "Move window into or create group " .. dir_names[dir],
    })
end

-- move out of group
for key, dir in pairs(directions) do
    hl.bind(mainMod .. " + SHIFT + ALT + " .. key, hl.dsp.window.move({ out_of_group = dir }), {
        description = "Move window out of group " .. dir_names[dir],
    })
end

-- SUPER + Comma/Period are reserved for focusing monitors in modules/binds.lua.
-- Binding them here too would run both actions: focusing a monitor and then
-- scrolling that monitor's active column, which can push a lone window offscreen.
local layout_binds = {
    { "Home",          "fit tobeg",      "Scroll layout to beginning (first column)" },
    { "End",           "fit toend",        "Scroll layout to end (last column)" },
    { "Equal",         "colresize +conf",  "Increase column width preset" },
    { "Minus",         "colresize -conf",  "Decrease column width preset" },
    { "Slash",         "expel r",          "Expel window to new column on the right" },
    { "SHIFT + Slash", "expel l",          "Expel window to new column on the left" },
    { "BracketLeft",   "consume r",        "Consume window from right into current column" },
    { "BracketRight",  "consume l",        "Consume window from left into current column" },
    { "D",             "fit visible",      "Fit all columns onto visible screen" },
    { "C",             "fit active",       "Fit active column to screen center" },
    { "SHIFT + D",     "inhibit_scroll",   "Toggle scroll inhibition (lock layout scrolling)" },
}

for _, bind in ipairs(layout_binds) do
    hl.bind(mainMod .. " + " .. bind[1], hl.dsp.layout(bind[2]), {
        description = bind[3],
    })
end
