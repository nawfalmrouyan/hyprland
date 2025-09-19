#!/bin/bash

MODE_FILE="/tmp/hyprland_scroller_mode"

function handle {
  if [[ ${1:0:8} == "scroller" ]]; then
    if [[ ${1:10:9} == "mode, row" ]]; then
      echo "Row" >"$MODE_FILE"
    elif [[ ${1:10:12} == "mode, column" ]]; then
      echo "Column" >"$MODE_FILE"
      #else
      #echo "" > "$MODE_FILE"
    fi
    hyprctl dispatch submap reset && pkill -SIGRTMIN+8 waybar # update the widget on waybar
  fi
}

# Initialize the mode file
echo "" >"$MODE_FILE"

socat - "UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do handle "$line"; done
