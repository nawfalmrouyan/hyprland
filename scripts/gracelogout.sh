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

# BRAVE=$(hyprctl clients | grep "class: brave-browser" | wc -l)
# CHROMIUM=$(hyprctl clients | grep "class: brave-browser" | wc -l)
# FIREFOX=$(hyprctl clients | grep "class: firefox" | wc -l)
ZEN=$(hyprctl clients | grep "class: zen-alpha" | wc -l)

# if [ "$BRAVE" -gt "1" ]; then
#   notify-send "Shutting down" "Brave multiple windows open"
#   exit 1
# elif [ "$CHROMIUM" -gt "1" ]; then
#   notify-send "Shutting down" "Chromium multiple windows open"
#   exit 1
# elif [ "$FIREFOX" -gt "1" ]; then
#   notify-send "Shutting down" "Firefox multiple windows open"
#   exit 1
if [ "$ZEN" -gt "1" ]; then
  notify-send "Shutting down" "Zen multiple windows open"
  exit 1
fi

sleep 2

TMUX=$(tmux list-sessions 2>/dev/null | wc -l)
if [ "$TMUX" -ne "0" ]; then
  notify-send "Shutting down" "Closing tmux sessions..."
  pkill -9 tmux
fi

# close all client windows
# required for graceful exit since many apps aren't good SIGNAL citizens
HYPRCMDS=$(hyprctl -j clients | jq -j '.[] | "dispatch closewindow address:\(.address); "')
hyprctl --batch "$HYPRCMDS" >>/tmp/hyprexitwithgrace.log 2>&1

notify-send "Shutting down" "Closing Applications..."

sleep 2

COUNT=$(hyprctl clients | grep "class:" | wc -l)
if [ "$COUNT" -eq "0" ]; then
  notify-send "Shutting down" "Closed Applications."
  hyprctl dispatch exit
  return
else
  notify-send "Shutting down" "Some apps didn't close. Not shutting down."
  exit 1
fi
