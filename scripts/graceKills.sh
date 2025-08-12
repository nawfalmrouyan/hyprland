#!/usr/bin/env bash
# Author: Suchith Sridhar
# Website: https://suchicodes.com/
#
# This script is used to manage power based controls on Hyprland
# These are operations like shutdown, lock, and logout.
#
# Before performing some of these operations we handle the closing of apps.
# If there are apps that can't be closed without losing data, then the power operation
# is cancelled and a notification about the cause of the cancellation is sent.

function close_applications() {
  ZEN=$(hyprctl clients | grep "class: zen" | wc -l)
  if [ "$ZEN" -gt "0" ]; then
    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Grace Killing Processes" "Zen multiple windows open"
    pkill -9 zen-bin
    exit 1
  fi

  sleep 2

  TMUX=$(tmux list-sessions 2>/dev/null | wc -l)
  if [ "$TMUX" -ne "0" ]; then
    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Grace Killing Processes" "Closing tmux sessions..."
    pkill -9 tmux
  fi

  if [[ $(pidof openconnect) ]]; then
    ~/.local/bin/mmuvpn down
    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Grace Killing Processes" "Closing mmuvpn sessions..."
  fi

  # ZELLIJ=$(zellij list-sessions 2>/dev/null | wc -l)
  # if [ "$ZELLIJ" -ne "0" ]; then
  #   notify-send "Grace Killing Processes" "Closing zellij sessions..."
  #   pkill -9 zellij
  # fi

  # close all client windows
  # required for graceful exit since many apps aren't good SIGNAL citizens
  HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
  hyprctl --batch "$HYPRCMDS" >>/tmp/hyprexitwithgrace.log 2>&1

  # notify-send "Grace Killing Processes" "Closing Applications..."

  sleep 2

  COUNT=$(hyprctl clients | grep "class:" | wc -l)
  if [ "$COUNT" -eq "0" ]; then
    # notify-send "Grace Killing Processes" "Closed Applications."
    return
  else
    DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus notify-send "Grace Killing Processes" "Some apps didn't close. Not shutting down."
    exit 1
  fi
}

close_applications

case $1 in
logout)
  hyprctl dispatch exit
  ;;
reboot)
  systemctl reboot
  ;;
shutdown)
  systemctl poweroff
  ;;
*) ;;
esac
