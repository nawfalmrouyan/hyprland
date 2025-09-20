#!/bin/bash

MODE_FILE="/tmp/hyprscroller-mode"

current_mode=$(cat "$MODE_FILE")

if [[ "$current_mode" =~ "Row" ]]; then
  hyprctl dispatch -- scroller:setmode column
  notify-send -a "t1" -r 91190 -t 2200 "Column mode active."
elif [[ "$current_mode" =~ "Column" ]]; then
  hyprctl dispatch -- scroller:setmode row
  notify-send -a "t1" -r 91190 -t 2200 "Row mode active."
else
  notify-send -a "t1" -r 91190 -t 2200 "Error: Could not detect current mode."
fi
