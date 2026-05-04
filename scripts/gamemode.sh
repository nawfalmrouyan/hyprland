#!/usr/bin/env sh
HYPRGAMEMODE=$(hyprctl getoption animations:enabled | awk 'NR==1{print $2}')

if [ "$HYPRGAMEMODE" = "true" ]; then
        hyprctl eval 'hl.config({ animations = { enabled = false }, decoration = { shadow = { enabled = false }, rounding = 0, blur = { enabled = false } }, general = { gaps_in = 0, gaps_out = 0, border_size = 0 } })'
        notify-send -u low "Hyprland" "Game Mode ENABLED"
else
        hyprctl reload
        notify-send -u low "Hyprland" "Game Mode DISABLED"
fi
