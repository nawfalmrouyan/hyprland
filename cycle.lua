local M = {}

function M.cycle(data)
	local w = hl.get_windows()

	local windows = {}

	for _, j in ipairs(w) do
		if data.class and j.initial_class == data.class then
			table.insert(windows, j)
		elseif data.title and j.title == data.title then
			table.insert(windows, j)
		end
	end

	if #windows == 0 then
		hl.exec_cmd(data.exec)
		return
	elseif #windows == 1 then
		hl.dispatch(hl.dsp.focus({ window = "address:" .. windows[1].address }))
		return
	end

	table.sort(windows, function(a, b)
		return a.focus_history_id < b.focus_history_id
	end)

	local active_window = hl.get_active_window()

	if active_window and hl.get_active_window().initial_class == windows[1].initial_class then
		hl.dispatch(hl.dsp.focus({ window = "address:" .. windows[#windows].address }))
		return
	end

	hl.dispatch(hl.dsp.focus({ window = "address:" .. windows[1].address }))
end

return M
