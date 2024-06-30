#!/bin/bash

mapfile -t ARR < <(
	hyprctl clients -j |
		jq -r '
           sort_by(.monitor,.workspace.id) |
          .[] |
          select(.workspace.name | startswith("special") | not) |
          select(.hidden==false) |
          [.address,"\(.class) 󰖲 \(.title)"] |
          @tsv'
)

size="${#ARR[@]}"
if [ "$size" -le 1 ]; then
	exit 1 # skip everything if we have 0 or 1 windows
fi

case "$1" in
menu)
	index=$(printf "%s\n" "${ARR[@]}" | cut -f2 | rofi -dmenu)
	if [ -z "$index" ]; then
		exit 1
	fi
	;;
next)
	activeAddr=$(hyprctl activewindow -j | jq -r .address)
	# grep line number is 1 and not zero based, so we don't need to ++ for the next window index
	index=$(printf "%s\n" "${ARR[@]}" | cut -f1 | grep -n "$activeAddr" | cut -d: -f1)
	if [ "$index" -ge "$size" ]; then
		index=0
	fi
	;;
*)
	exit 1
	;;
esac

addr=$(printf "%s" "${ARR[index]}" | cut -f1)
hyprctl dispatch focuswindow address:"$addr"
