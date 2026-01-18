#!/usr/bin/env bash

selection=$(printf 'Shutdown\nReboot\nLog Out\nLock' | vicinae dmenu) || exit 1

case $selection in
"Lock")
  dms ipc lock lock
  ;;
"Reboot")
  hyprshutdown -p "systemctl soft-reboot"
  ;;
"Shutdown")
  hyprshutdown -p "systemctl poweroff"
  ;;
"Log Out")
  hyprshutdown
  ;;
esac
