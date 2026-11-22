local mainMod = "SUPER"

-- Cursor submap (similar to the Mouse mode in Sway)
hl.bind(mainMod .. "+ CTRL + C", function()
	hl.config ({ cursor = { hide_on_key_press = false, inactive_timeout = 0 } })
	hl.dispatch(hl.dsp.submap("cursor"))
end, { description = "Enter keyboard-driven cursor mode (wl-kbptr submap)" })

hl.define_submap("cursor", function()
	-- Jump cursor to a position
	hl.bind("A", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.submap(\"reset\")' && wl-kbptr -o modes=tile,click -o mode_floating.source=detect && hyprctl dispatch 'hl.dsp.submap(\"cursor\")'"), { description = "Jump cursor to tiled window via wl-kbptr" })
	hl.bind("W", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.submap(\"reset\")' && wl-kbptr -o modes=floating,click -o mode_floating.source=detect && hyprctl dispatch 'hl.dsp.submap(\"cursor\")'"), { description = "Jump cursor to floating window via wl-kbptr" })

	-- Cursor movement
	hl.bind("J", hl.dsp.exec_cmd("wlrctl pointer move 0 25"), { repeating = true, description = "Move cursor down 25px" })
	hl.bind("K", hl.dsp.exec_cmd("wlrctl pointer move 0 -25"), { repeating = true, description = "Move cursor up 25px" })
	hl.bind("L", hl.dsp.exec_cmd("wlrctl pointer move 25 0"), { repeating = true, description = "Move cursor right 25px" })
	hl.bind("H", hl.dsp.exec_cmd("wlrctl pointer move -25 0"), { repeating = true, description = "Move cursor left 25px" })

	-- Left button
	hl.bind("F", hl.dsp.exec_cmd("wlrctl pointer click left"), { description = "Left mouse click" })
	-- Middle button
	hl.bind("D", hl.dsp.exec_cmd("wlrctl pointer click middle"), { description = "Middle mouse click" })
	-- Right button
	hl.bind("S", hl.dsp.exec_cmd("wlrctl pointer click right"), { description = "Right mouse click" })

	-- Scroll up and down
	hl.bind("G", hl.dsp.exec_cmd("wlrctl pointer scroll 30 0"), { repeating = true, description = "Scroll cursor down" })
	hl.bind("T", hl.dsp.exec_cmd("wlrctl pointer scroll -30 0"), { repeating = true, description = "Scroll cursor up" })

	-- Scroll left and right
	hl.bind("E", hl.dsp.exec_cmd("wlrctl pointer scroll 0 -30"), { repeating = true, description = "Scroll cursor left" })
	hl.bind("R", hl.dsp.exec_cmd("wlrctl pointer scroll 0 30"), { repeating = true, description = "Scroll cursor right" })

	-- Exit cursor submap
	hl.bind("escape", function()
		hl.config ({ cursor = { hide_on_key_press = true, inactive_timeout = 3 } })
		hl.dispatch(hl.dsp.submap("reset"))
	end, { description = "Exit cursor submap" })
end)
