#!/bin/bash

LAYOUT="$HOME/.config/hypr/wlogout/layout"
STYLE="$HOME/.config/hypr/wlogout/style.css"

if [[ ! $(pidof wlogout) ]]; then
  # wleave -l ${LAYOUT} -C ${STYLE} -b 5 -B 400 -T 400 -p layer-shell -k
  wlogout -p layer-shell --layout ${LAYOUT} --css ${STYLE} --buttons-per-row 5 --margin-top 400 --margin-bottom 400
else
  pkill wlogout
fi
