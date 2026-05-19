hl.plugin.hyprview.configure({
	gesture_distance = 200,
	on_close = function()
		hl.dispatch(hl.dsp.submap("reset"))
	end,
	keyboard = {
		enabled = true,
		grab = false,
		remember_selection = true,
		wrap = true,
		activation_closes_overview = true,
		focus_follows_selection = false,
	},
	mouse = {
		select_follows_hover = true,
		edge_navigation = true,
		edge_navigation_snap = true,
		edge_navigation_speed = 1.0,
		hitbox_expansion = 16,
		nearest_hitbox = true,
		snap_pan = true,
		snap_pan_zone = 96,
	},
	scrolling = {
		scroll_moves_up_down = true,
		default_zoom = 0.5,
		window_gap = 0,
		workspace_gap = 0,
		background_blur = false,
		show_workspace_layers = true,
		backdrop_col = "rgba(000000ff)",
		workspace_shadow_col = "rgba(00000000)",
		workspace_shadow_size = 0,
		focus_indicator = "overview_box",
		active_border_size = 4,
		hover_col = "rgba(a7c7ff33)",
		drop_target_col = "rgba(a7c7ff22)",
		drag_alpha = 1.0,
		invalid_drag_alpha = 0.55,
		edge_scroll_zone = 64,
		edge_scroll_speed = 1.0,
		hover_activate_ms = 600,
		workspace_annotation = "id",
		workspace_annotation_position = "top_left",
		workspace_annotation_color = "rgba(ffffffff)",
		workspace_annotation_bg_col = "rgba(00000099)",
		workspace_annotation_font_size = 14,
		active_indicator = "corner",
		active_indicator_col = "rgba(ffffffff)",
		insertion_marker_labels = true,
		insertion_max_markers = 8,
		append_marker_count = 1,
		insertion_marker_col = "rgba(a7c7ff44)",
		invalid_insertion_marker_col = "rgba(ff5c5c55)",
	},
})

hl.plugin.hyprview.gesture({
	fingers = 3,
	direction = "down",
	gesture = "overview",
})

hl.bind("SUPER+G", function()
	hl.plugin.hyprview.overview("toggle")
end)
