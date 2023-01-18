#!/bin/bash

## Set GTK Themes, Icons, Cursor and Fonts

THEME='Catppuccin-Mocha-Standard-Mauve-Dark'
# ICONS='Qualia-purple-dark'
# FONT='Fira Sans Condensed 13'
CURSOR='Catppuccin-Mocha-Mauve-Cursors'

SCHEMA='gsettings set org.gnome.desktop.interface'

apply_themes() {
  ${SCHEMA} gtk-theme "$THEME"
  # ${SCHEMA} icon-theme "$ICONS"
  ${SCHEMA} cursor-theme "$CURSOR"
  # ${SCHEMA} font-name "$FONT"
}

apply_themes
