#!/usr/bin/env bash

# delay start, wait for hyprpanel to load
sleep 10

# Initialize state variable
bar_visible=$(hyprpanel iwv bar-0)

while [ "$bar_visible" = true ]; do
  if [[ $(pidof gjs) ]] && [ "$bar_visible" = true ]; then
    ags -i hyprpanel toggle bar-0
    bar_visible=false
  fi
done

# Monitor cursor position
while true; do
  # Get cursor position using hyprctl
  read Y < <(hyprctl cursorpos -j | sed -n '4p' | cut -d":" -f2)

  if [ "$Y" -le 5 ] && [ "$bar_visible" = false ]; then
    ags -i hyprpanel toggle bar-0
    bar_visible=true
    while [ "$Y" -le 35 ]; do
      sleep 0.5
      read Y < <(hyprctl cursorpos -j | sed -n '4p' | cut -d":" -f2)
    done
  elif [ "$Y" -gt 35 ] && [ "$bar_visible" = true ]; then
    ags -i hyprpanel toggle bar-0
    bar_visible=false
  fi
  sleep 0.5
done
