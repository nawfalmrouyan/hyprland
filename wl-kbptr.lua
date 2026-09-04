local mainMod = "SUPER"

-- Cursor submap (similar to the Mouse mode in Sway)
hl.bind(mainMod .. "+ CTRL + C", function()
	hl.exec_cmd("hyprctl keyword cursor:inactive_timeout 0; hyprctl keyword cursor:hide_on_key_press false")
	hl.dispatch(hl.dsp.submap("cursor"))
end, { description = "Enter cursor submap" })

hl.define_submap("cursor", function()
	-- Jump cursor to a position
	hl.bind("A", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.submap(\"reset\")' && wl-kbptr -o modes=floating,click -o mode_floating.source=detect && hyprctl dispatch 'hl.dsp.submap(\"cursor\")'")
	)

	-- Cursor movement
	hl.bind("J", hl.dsp.exec_cmd("wlrctl pointer move 0 10"), { repeating = true })
	hl.bind("K", hl.dsp.exec_cmd("wlrctl pointer move 0 -10"), { repeating = true })
	hl.bind("L", hl.dsp.exec_cmd("wlrctl pointer move 10 0"), { repeating = true })
	hl.bind("H", hl.dsp.exec_cmd("wlrctl pointer move -10 0"), { repeating = true })

	-- Left button
	hl.bind("F", hl.dsp.exec_cmd("wlrctl pointer click left"))
	-- Middle button
	hl.bind("D", hl.dsp.exec_cmd("wlrctl pointer click middle"))
	-- Right button
	hl.bind("S", hl.dsp.exec_cmd("wlrctl pointer click right"))

	-- Scroll up and down
	hl.bind("G", hl.dsp.exec_cmd("wlrctl pointer scroll 30 0"), { repeating = true })
	hl.bind("T", hl.dsp.exec_cmd("wlrctl pointer scroll -30 0"), { repeating = true })

	-- Scroll left and right
	hl.bind("E", hl.dsp.exec_cmd("wlrctl pointer scroll 0 -30"), { repeating = true })
	hl.bind("R", hl.dsp.exec_cmd("wlrctl pointer scroll 0 30"), { repeating = true })

	-- Exit cursor submap
	hl.bind("escape", function()
		hl.exec_cmd("hyprctl keyword cursor:inactive_timeout 3; hyprctl keyword cursor:hide_on_key_press true")
		hl.dispatch(hl.dsp.submap("reset"))
	end)
end)
