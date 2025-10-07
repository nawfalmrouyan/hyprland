#!/usr/bin/env bash

set -e

rofi_command="vicinae dmenu"

menu() {
  printf "1. Performance\n"
  printf "2. Balanced\n"
  printf "3. Power Saver\n"
}

main() {
  choice=$(menu | ${rofi_command} | cut -d. -f1)

  case $choice in
  1)
    notify-send "Power Profile" "Setting power profile: Performance"
    powerprofilesctl set performance
    return
    ;;
  2)
    notify-send "Power Profile" "Setting power profile: Balanced"
    powerprofilesctl set balanced
    return
    ;;
  3)
    notify-send "Power Profile" "Setting power profile: Power Saver"
    powerprofilesctl set power-saver
    return
    ;;
  esac
}

main
