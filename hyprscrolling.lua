hl.config({
    scrolling = {
        column_width = 0.75,
        fullscreen_on_one_column = false,
        explicit_column_widths = "0.25, 0.5, 0.75, 1.0",
        focus_fit_method = 1,
        follow_min_visible = 0.25,
    },
})

hl.bind(mainMod .. " + L", hl.dsp.layout("focus r"))
hl.bind(mainMod .. " + H", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + K", hl.dsp.layout("focus u"))
hl.bind(mainMod .. " + J", hl.dsp.layout("focus d"))
hl.bind(mainMod .. " +  CTRL + L", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " +  CTRL + H", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + Home", hl.dsp.layout("fit tobeg"))
hl.bind(mainMod .. " + End", hl.dsp.layout("fit toend"))
hl.bind(mainMod .. " + Equal", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + Minus", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + Comma", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + Period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + Slash", hl.dsp.layout("expel r"))
hl.bind(mainMod .. " + SHIFT + Slash", hl.dsp.layout("expel l"))
hl.bind(mainMod .. " + BracketLeft", hl.dsp.layout("consume r"))
hl.bind(mainMod .. " + BracketRight", hl.dsp.layout("consume l"))
hl.bind(mainMod .. " + C", hl.dsp.layout("togglefit"))
hl.bind(mainMod .. " + D", hl.dsp.layout("fit visible"))
-- hl.bind(mainMod .. " + S", hl.dsp.layout("fit all"))

hl.bind(main .. " + SHIFT + L", hl.dsp.window.move({ "r" }))
hl.bind(main .. " + SHIFT + H", hl.dsp.window.move({ "l" }))
hl.bind(main .. " + ALT + L", hl.dsp.window.move({ into_or_create_group, "r" }))
hl.bind(main .. " + ALT + H", hl.dsp.window.move({ into_or_create_group, "l" }))
hl.bind(main .. " + ALT + K", hl.dsp.window.move({ into_or_create_group, "u" }))
hl.bind(main .. " + ALT + J", hl.dsp.window.move({ into_or_create_group, "d" }))
hl.bind(main .. " + SHIFT + ALT, L", hl.dsp.exec_cmd("hyprctl dispatch moveoutofgroup r"))
hl.bind(main .. " + SHIFT + ALT, H", hl.dsp.exec_cmd("hyprctl dispatch moveoutofgroup l"))
hl.bind(main .. " + SHIFT + ALT, K", hl.dsp.exec_cmd("hyprctl dispatch moveoutofgroup u"))
hl.bind(main .. " + SHIFT + ALT, J", hl.dsp.exec_cmd("hyprctl dispatch moveoutofgroup d"))
hl.bind(main .. " + SHIFT + K", hl.dsp.window.move({ "u" }))
hl.bind(main .. " + SHIFT + J", hl.dsp.window.move({ "d" }))
