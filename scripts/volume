#!/bin/bash

iDIR="$HOME/.config/hypr/mako/icons"

# Get Volume
get_volume() {
	volume=$(pamixer --get-volume)
	echo "$volume"
}

# Get icons
get_icon() {
	current=$(get_volume)
	if [[ "$current" -eq "0" ]]; then
		echo "$iDIR/volume-mute.png"
	elif [[ ("$current" -ge "0") && ("$current" -le "30") ]]; then
		echo "$iDIR/volume-low.png"
	elif [[ ("$current" -ge "30") && ("$current" -le "60") ]]; then
		echo "$iDIR/volume-mid.png"
	elif [[ ("$current" -ge "60") && ("$current" -le "100") ]]; then
		echo "$iDIR/volume-high.png"
	fi
}

# Notify
notify_user() {
	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume : $(get_volume)"
}

# Increase Volume
inc_volume() {
	pamixer -i 5 && notify_user
}

# Decrease Volume
dec_volume() {
	pamixer -d 5 && notify_user
}

# Toggle Mute
toggle_mute() {
	if [ "$(pamixer --get-mute)" == "false" ]; then
		pamixer -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
	elif [ "$(pamixer --get-mute)" == "true" ]; then
		pamixer -u && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pamixer --source 66 --get-mute)" == "false" ]; then
		pamixer -m --source 66 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
	elif [ "$(pamixer --source 66 --get-mute)" == "true" ]; then
		pamixer -u --source 66 && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
	fi
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
else
	get_volume
fi
