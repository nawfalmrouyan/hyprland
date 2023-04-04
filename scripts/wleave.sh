#!/bin/bash

LAYOUT="$HOME/.config/hypr/wleave/layout"
STYLE="$HOME/.config/hypr/wleave/style.css"

if [[ ! $(pidof wlogout) ]]; then
  # wleave -l ${LAYOUT} -C ${STYLE} -b 5 -B 400 -T 400 -p layer-shell -k
  wlogout --layout ${LAYOUT} --css ${STYLE} --buttons-per-row 5 --margin-top 400 --margin-bottom 400
else
  pkill wlogout
fi
