#!/bin/bash

MODE_FILE="/tmp/hyprscroller-mode"

handle_mode_listener() {
  case $1 in
  *"scroller>>mode, row"*)
    current_mode="row"
    handle_mode_reader
    hyprctl dispatch submap reset && pkill -SIGRTMIN+8 waybar # && echo "Signal sent."
    ;;
  *"scroller>>mode, column"*)
    current_mode="column"
    handle_mode_reader
    hyprctl dispatch submap reset && pkill -SIGRTMIN+8 waybar # && echo "Signal sent."
    ;;
  esac
}

handle_mode_reader() {
  if [[ "$current_mode" == "row" ]]; then
    icon="Row"
    percent=0
    class="mode-row"
  elif [[ "$current_mode" == "column" ]]; then
    icon="Column"
    percent=100
    class="mode-column"
  else
    icon="Row"
    percent=0
    class=""
  fi

  echo "{\"text\":\"$icon\", \"tooltip\":\"Scroller Mode: $current_mode\", \"class\":\"$class\", \"percentage\": $percent}" >"$MODE_FILE"
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR"/hypr/"$HYPRLAND_INSTANCE_SIGNATURE"/.socket2.sock | while read -r line; do handle_mode_listener "$line"; done
